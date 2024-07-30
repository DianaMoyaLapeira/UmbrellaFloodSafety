//
//  TabController.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 20/7/24.
//

import Foundation

enum Tab {
    case map
    case messages
    case learn
    case profile
}

class TabController: ObservableObject {
    @Published var activeTab = Tab.map
    
    func open(_ tab: Tab) {
        activeTab = tab
    }
}
