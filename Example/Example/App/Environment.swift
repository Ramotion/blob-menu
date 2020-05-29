//
//  Environment.swift
//  Example
//
//  Created by Igor K. on 24.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI
import BlobMenu


extension EnvironmentValues {
    var menuEnvironment: BlobMenuModel {
        get { return self[MenuEnvironmentKey.self] }
        set { self[MenuEnvironmentKey.self] = newValue }
    }
}

struct MenuEnvironmentKey: EnvironmentKey {
    static let defaultValue = BlobMenuModel(items: BlobMenuItem.standard)
}

extension BlobMenuItem {
    static let standard: [BlobMenuItem] = [
        BlobMenuItem(selectedIcon: Image.calendarSelected, unselectedIcon: Image.calendarUnselected),
        BlobMenuItem(selectedIcon: Image.chatSelected, unselectedIcon: Image.chatUnselected),
        BlobMenuItem(selectedIcon: Image.favoriteSelected, unselectedIcon: Image.favoriteUnselected),
    ]
    
    static let extended: [BlobMenuItem] =
        standard + [BlobMenuItem(selectedIcon: Image.profileSelected, unselectedIcon: Image.profileUnselected)]
}


extension Image {
    static let calendarSelected = Image("Icon_Calendar_selected")
    static let calendarUnselected = Image("Icon_Calendar_unselected")
    static let chatSelected = Image("Icon_Chat_selected")
    static let chatUnselected = Image("Icon_Chat_unselected")
    static let favoriteSelected = Image("Icon_Favorite_selected")
    static let favoriteUnselected = Image("Icon_Favorite_unselected")
    static let profileSelected = Image("Icon_Profile_selected")
    static let profileUnselected = Image("Icon_Profile_unselected")
}
