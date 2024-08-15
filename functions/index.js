/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const OpenAI = require("openai");
const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const apn = require("apn");
const path = require("path");
const jwt = require("jsonwebtoken");
const fs = require("fs");

admin.initializeApp();

const db = admin.firestore();


const apnProvider = new apn.Provider({
  token: {
    key: path.join(__dirname, "AuthKey_AS9W7F6M4U.p8"),
    keyId: "AS9W7F6M4U",
    teamId: "N8YGT32D5B",
  },
  production: false,
});

const teamId = "N8YGT32D5B";
const serviceId = "com.UmbrellaFloodSafety.weatherkit-client";
const kId = "SN4RX6DW9J";
const serverKeyPath = path.join(__dirname, "AuthKey_SN4RX6DW9J.p8");

const privateKey = fs.readFileSync(serverKeyPath, "utf8");

const openAIKey = functions.config().openai.apikey;

/**
 * Generates a JWT for auth with Apple WeatherKit API.
 * @return {string} The generated JWT.
 */
function generateJWT() {
  const token = jwt.sign({}, privateKey, {
    algorithm: "ES256",
    expiresIn: "1h",
    issuer: teamId,
    audience: "https://api.weatherkit.apple.com",
    subject: serviceId,
    keyid: kId,
  });
  return token;
}

exports.callOpenAIAdult = functions.https
    .onCall(
        async (data, context) => {
          try {
            const userMessage = data.message;
            if (!userMessage) {
              throw new functions.https.HttpsError("invalid-argument",
                  "The function must be called with a \"message\" argument.");
            }

            const openai = new OpenAI({
              apiKey: openAIKey,
            });

            const completion = await openai.chat.completions.create({
              messages: [
                {role: "system", content: `You are a helpful assistant
        providing short and helpful reply suggestions to adults 
        replying to children 
        during flood emergencies and in day-to-day conversation.`},
                {role: "user", content: userMessage},
              ],
              model: "ft:gpt-3.5-turbo-0125:personal::9jH4IGCI",
            });

            return {response: completion.choices[0]};
          } catch (error) {
            console.log(`oh no error ${error.message}`);
            throw new functions
                .https
                .HttpsError("internal",
                    "Unable to process the request.", error.message);
          }
        });

exports.callOpenAIChild = functions.https
    .onCall(
        async (data, context) => {
          try {
            const userMessage = data.message;
            if (!userMessage) {
              throw new functions.https.HttpsError("invalid-argument",
                  "The function must be called with a \"message\" argument.");
            }

            const openai = new OpenAI({
              apiKey: openAIKey,
            });

            const completion = await openai.chat.completions.create({
              messages: [
                {role: "system", content: `You are a helpful assistant
          providing short and helpful reply suggestions to children 
          replying to adults
          during flood emergencies and in day-to-day conversation.`},
                {role: "user", content: userMessage},
              ],
              model: "ft:gpt-3.5-turbo-0125:personal::9jdF6x9a",
            });

            return {response: completion.choices[0]};
          } catch (error) {
            throw new functions
                .https
                .HttpsError("internal",
                    "Unable to process the request.", error.message);
          }
        });

/**
Send message notification to conversation members when a message is sent out
 */
exports.sendMessageNotification = functions.firestore
    .document("conversations/{conversationId}/messages/{messageId}")
    .onCreate(async (snapshot, context) => {
      try {
        const messageData = snapshot.data();
        const conversationId = context.params.conversationId;
        const senderId = messageData.senderId;
        const messageContent = messageData.content;

        const conversationDoc = await admin.firestore()
            .collection("conversations")
            .doc(conversationId)
            .get();
        if (!conversationDoc.exists) {
          console.error("Conversation ${conversationId} does not exist");
          return null;
        }

        const conversationData = conversationDoc
            .data();
        const participants = conversationData
            .participants;

        const userPromises = participants.map((username) => admin.firestore()
            .collection("users")
            .doc(username).get());
        const userDocs = await Promise.all(userPromises);

        const tokens = userDocs.map((userDoc) => {
          if (!userDoc.exists) {
            console.error(`User ${userDoc.id} does not exist`);
            return null;
          }
          const userData = userDoc.data();
          return userData.deviceToken;
        }).filter((token) => !!token);

        if (tokens.length === 0) {
          console.log("No valid APNs tokens found for recipients");
          return null;
        }

        const notifications = tokens.map((token) => {
          const notification = new apn.Notification();
          notification.aps = {
            alert: {
              title: "Umbrella Flood Safety",
              subtitle: `New message from ${senderId}`,
              body: messageContent,
            },
            sound: "default",
            badge: 1,
          };
          notification.payload = {conversationId};
          notification.topic = "com.dianamoya.UmbrellaFloodSafety";
          return {notification, token};
        });

        const sendPromises = notifications.map(
            ({notification, token}) =>
              apnProvider.send(notification, token),
        );
        const results = await Promise
            .all(sendPromises);

        results.forEach((result, index) => {
          const {
            sent,
            failed,
          } = result;
          if (failed
              .length > 0) {
            console.error(
                `Error sending notification to ${notifications[index].token}:`,
                failed,
            );
          } else {
            console.log(
                `Notification sent successfully to ${
                  notifications[index].token
                }`,
            );
            console.log(`sent: ${sent}`);
          }
        });
      } catch (error) {
        console.error("Error sending message notification:", error);
        return null;
      }
    });

/**
 * Scheduled function to check for flood alerts every 30 minutes.
 */
exports.scheduledFloodAlertNotifications = functions.pubsub
    .schedule("every 30 minutes")
    .onRun( async (context) => {
      await checkFloodAlertsForUsers();
      console.log("finished running flood alerts and sending notifications.");
    });

/**
* Gets weather alerts for a user's location.
* @param {number} latitude - The latitude.
* @param {number} longitude - The longitude.
* @param {string} country - The country.
* @param {string} dataSets - The data sets (in this case, weatherAlerts).
* @param {string} timezone - The timezone.
* @param {string} language - The language (only US english for now,
* update later).
* @return {Promise<Object|null>} The weather alerts data or null if
  an error occurs :().
*/
async function getWeatherAlerts(
    latitude,
    longitude,
    country,
    dataSets,
    timezone,
    language,
) {
  const token = generateJWT();
  const url = `https://weatherkit.apple.com/api/v1/weather/${language}/${latitude}/${longitude}?dataSets=${dataSets}&country=${country}&timezone=${timezone}`;

  try {
    const response = await fetch(url, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    if (response.ok) {
      const JSONresponse = await response.json();
      return JSONresponse;
    } else {
      console.error(`Unexpected response code: ${response.status}`);
      return null;
    }
  } catch (error) {
    console.error("Error fetching weather alerts:", error);
    return null;
  }
}

/**
 * Sends an APN with the alert description.
 * @param {string} deviceToken - The APN device token.
 * @param {string} alertDescription - The alert description.
 * @param {string} username - The username of the receiver.
 */
async function sendAlertNotification(deviceToken, alertDescription, username) {
  const notification = new apn.Notification();
  notification.aps = {
    alert: {
      title: "Flood Safety Warning",
      subtitle: `${alertDescription} in ${username}'s Area`,
      body: "Check up on them to make sure they're safe.",
    },
    sound: "default",
    badge: 1,
  };
  notification.payload = {alertDescription};
  notification.topic = "com.dianamoya.UmbrellaFloodSafety";

  try {
    const sendPromise = apnProvider.send(notification, deviceToken);
    const result = await sendPromise;
    console.log(`success: ${result.sent.length} 
      failed: ${result.failed.length}`);
  } catch (error) {
    console.log(`Error sending flood alert notification to 
      user ${username}: ${error}`);
  }
}

/**
 * Checks for flood alerts and sends notifications to
 * users and their group participants.
 */
async function checkFloodAlertsForUsers() {
  try {
    const usersSnapshot = await db.collection("users").get();
    if (usersSnapshot.empty) {
      console.log("No users found");
      return;
    }

    const users = [];
    usersSnapshot.forEach((doc) => {
      users.push({username: doc.id, ...doc.data()});
    });

    const language = "en-US";
    const country = "US";
    const timezone = "America/Los_Angeles";
    const dataSets = "weatherAlerts";

    for (const user of users) {
      if (!user.location || !Array.isArray(user.location)) {
        console.error(`Invalid location for user ${user.username}`);
        continue;
      }

      const [latitude, longitude] = user.location;
      console.log(`user ${user} latitude: ${latitude} 
        longitude: ${longitude}`);
      const alerts = await getWeatherAlerts(
          latitude,
          longitude,
          country,
          dataSets,
          timezone,
          language,
      );

      if (alerts && alerts.weatherAlerts && alerts.weatherAlerts.alerts) {
        const alertArray = alerts.weatherAlerts.alerts;

        alertArray.forEach(async (alert) => {
          if (alert.phenomenon.toLowerCase().includes("flood")) {
            const groupsSnapshot = await db.collection("groups")
                .where("members", "array-contains", user.username).get();

            for (const groupDoc of groupsSnapshot.docs) {
              const groupData = groupDoc.data();

              for (const member of groupData.members) {
                const memberDoc = await db.collection("users").doc(member)
                    .get();
                const memberDocData = memberDoc.data();

                if (memberDocData && memberDocData.deviceToken) {
                  await sendAlertNotification(
                      memberDocData.deviceToken, alert.description,
                      user.username,
                  );
                }
              }
            }
          }
        });
      }
    }
  } catch (error) {
    console.error("Error in checkFloodAlertsForUsers:", error);
  }
}
