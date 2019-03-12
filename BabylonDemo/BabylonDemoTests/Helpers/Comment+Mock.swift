//
//  Comment+Mock.swift
//  BabylonDemoTests
//
//  Created by Julien Ducret on 3/11/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import Foundation
@testable import BabylonDemo

extension Comment {
    
    static func makeMocks(count: Int) -> [Comment] {
        let data = Comment(postId: 0, id: 0, name: "NAME_0", email: "EMAIL_0", body: "BODY_0")
        return [Comment](repeating: data, count: count)
    }
}
