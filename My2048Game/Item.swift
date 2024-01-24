//
//  Item.swift
//  My2048Game
//
//  Created by Renvle RS on 1/24/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
