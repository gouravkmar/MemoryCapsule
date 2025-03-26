//
//  Memory.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 26/03/25.
//

import Foundation
import UIKit
struct Memory : Identifiable, Codable {
    let id : String
    let name : String
    let title : String
    let description : String?
    var imageURL : String
    let lat : Double
    let long : Double
    let timestamp : Date
    var image : UIImage? = nil
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
}


struct MemoryFields {
    static let title = "title"
    static let lat = "lat"
    static let long = "long"
    static let timestamp = "timestamp"
    static let name = "name"
    
    
}
