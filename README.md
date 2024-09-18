# Umbrella Flood Safety - Flood Safety Companion IOS App 
Umbrella Flood Safety was created to enhance flood safety awareness, prepardness, and effectiveness of responses to flood emergencies. The app was inspired by the impact of recent devastating floods in the Miami-Dade and Costa Rica regions. 

## Features
- **Real-Time Flood Alerts/Location Sharing**: Users receive push notifications when a flood detected near their location or near an "Umbrella" (flood safety group) member's location. Location updates from each device ensure that the map represents each user's location. 
- **Interactive Flood Map**: View the flood status of each member along their location on an interactive map. 
- **Emergency Communication**: Two GPT-4o mini models were fine-tuned to provide automated reply suggestions pertaining to day-to-day conversations and facilitating communication of crucial information during emergency situations in which communicating effectively might be difficult. 
- **Emergency Guides**: Interactive, easy-to-reach guides personalized for child or adult users, providing acctionable suggestions for emergency management. Sources used for the informational emergency guides include The Red Cross and NOAA. 
- **Emergency Plans**: Users can make emergency plans for members of their Umbrellas. Emergency plans are based on the [Red Cross' Family Disaster Plan](https://www.redcross.org/content/dam/redcross/atg/PDF_s/Preparedness___Disaster_Recovery/General_Preparedness___Recovery/Home/ARC_Family_Disaster_Plan_Template_r083012.pdf)
- **User Profiles**: Personalized settings and preferences, easy to join and create flood safety groups known as Umbrellas, unblock users. 
- **Avatars**: Each user makes a personalized avatar, doubling as a fun and engaging activity to connect users, especially young ones, with the app, and helping identify who each user is. 
- **User Safety**: Users can block and report each other, improving the safety standard of Umbrella Flood Safety as a social media platform. 

## Architecture
Umbrella uses a client-server architecture, with the client being an iOS application developed in Swift, and the server-side elements including Firebase for backend services, real-time databases, authentication, and cloud functions. The MVVM architectural pattern for SwiftUI was used loosely to structure the app. 

### Components 
- Client (iOS App)
    - Swift and SwiftUI: The app is developed with Swift, using SwiftUI and the underlying UIKit for the user interface. 
    - MapKit: Used for displaying user's locations on an interactive map. 
    - WeatherKit: iOS SDK is used to check for flood hazards in user's area in real-time. 
    - Local storage: The app uses UserDefaults to store current username and the current user's avatar, enabling offline functionality for some app functions. 
-  Backend Services
    - Firebase Firestore: Used to structure, store, and scale data in real-time, including user data, conversations, emergency plans, reports, and groups (known as Umbrellas in the app).
    - Firebase Authentication: Used to provide a secure method for users to create their account with a username/password or delete it if they wish. 
    - Firebase Cloud Functions: Handles server-side logic, including triggering push notifications when a new message is sent or if a flood warning exists in a user's area. 
- APIs and Other Services
    - WeatherKit API: Used server-side to check for flood hazards in user's locations, which triggers push notifications if needed. 
    - Apple Push Notification Service (APNS): Used with Cloud Functions to send push notifications to user's devices when a new message is added to a conversation or when a flood alert is detected. 
    - OpenAI API: Two GPT-4o mini models were fine tuned, one for adults replying to children and the other for children replying to adults. They provide reply suggestions to user's messages to facilitate efficient conversations during difficult moments. Children are shown two possible replies and adults are shown three. 
