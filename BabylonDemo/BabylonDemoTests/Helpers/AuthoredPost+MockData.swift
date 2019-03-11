//
//  AuthoredPost+MockData.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/10/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
@testable import BabylonDemo

extension AuthoredPost {
    
    static var mock: AuthoredPost {
        return AuthoredPost(post: Post(userId: 0, id: 0, title: "TITLE_0", body: "BODY_0"), author: User(id: 0, name: "USER_0", username: "USERNAME_0", email: "EMAIL_0"))
    }
    
    static func makeMockData(count: Int) -> [AuthoredPost] {
        return [AuthoredPost](repeating: mock, count: count)
    }
}
