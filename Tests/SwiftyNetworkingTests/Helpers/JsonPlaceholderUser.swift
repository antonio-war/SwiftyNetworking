//
//  JsonPlaceholderUser.swift
//
//
//  Created by Antonio Guerra on 06/08/24.
//

import Foundation
@testable import SwiftyNetworking

struct JsonPlaceholderUser: Identifiable, SwiftyNetworkingModel {
    var id: Int
    var name: String
}
