//
//  Memory.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 26/03/25.
//

import Foundation
import UIKit
import SwiftUICore
struct Memory : Identifiable, Codable {
    let id : String
    let name : String
    let title : String
    let description : String?
    var imageURL : String
    let lat : Double
    let long : Double
    let timestamp : Date
    var image : Image? = nil
    func scaled()-> Self {
        return Memory(
            id: id,
            name: name,
            title: title,
            description: description,
            imageURL: imageURL,
            lat: lat  * scaleFactor,
            long: long * scaleFactor,
            timestamp: timestamp
        )
    }
    enum CodingKeys: CodingKey {
        case id
        case name
        case title
        case description
        case imageURL
        case lat
        case long
        case timestamp
    }
    
    static let defaultMemory = Memory(
        id: UUID().uuidString,
        name: "Sample User",
        title: "Beautiful Sunset",
        description: "A mesmerizing view of the sun setting over the hills.",
        imageURL: "https://source.unsplash.com/random/300x200",
        lat: 37.7749,
        long: -122.4194,
        timestamp: Date()
    )
}


struct MemoryFields {
    static let title = "title"
    static let lat = "lat"
    static let long = "long"
    static let timestamp = "timestamp"
    static let name = "name"
    
    
}
