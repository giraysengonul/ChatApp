//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 24.12.2022.
//

import Foundation
struct MessageViewModel {
    private let lastUser: LastUser
    init(lastUser: LastUser) {
        self.lastUser = lastUser
    }
    var profileImage: URL?{
        return URL(string: lastUser.user.profileImageUrl)
    }
    var timestampString: String{
        let date = lastUser.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}
