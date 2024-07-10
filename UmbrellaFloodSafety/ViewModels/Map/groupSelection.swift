//
//  groupSelection.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 7/7/24.
//

import Foundation
import Combine


@Observable
class GroupSelection {
    
    static let shared = GroupSelection()
    var selectedGroupId: String = ""
    var firebaseManager = FirebaseManager.shared
    var selection: String = "No Umbrella yet"
    var isLoading = true
    private var cancellables = Set<AnyCancellable>()
    
    private func setupSubscriptions() {
            firebaseManager.$userGroups
                .sink { [weak self] userGroups in
                    guard let self = self else { return }
                    if let firstId = userGroups.keys.sorted().first {
                        self.selection = firstId
                        print(self.selection)
                        self.isLoading = false
                    } else {
                        self.selection = "No Umbrellas yet"
                    }
                }
                .store(in: &cancellables)
        }
}
