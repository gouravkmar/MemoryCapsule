//
//  CloudStorage.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import FirebaseStorage
import UIKit
import SwiftUICore
enum CloudError : Error {
    case failedToCompress
    case failedToUpload
    case badURL
    case imageMissing
}
class CloudStorage {
    static let shared = CloudStorage()
    
    private init() {}
    private let storageRef = Storage.storage().reference()
    
    func uploadImage(image : UIImage)async throws-> String{
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw CloudError.failedToCompress
        }
        let imageRef = storageRef.child("memories/\(UUID().uuidString).jpg")
        do {
            let metadata = try await imageRef.putDataAsync(imageData)
            let url = try await imageRef.downloadURL()
            print("Image uploaded, metadata is: \(metadata)")
            return url.absoluteString
        }catch {
            throw CloudError.failedToUpload
        }
    }
    
    func downloadImage(urlString : String)async throws -> Image? {
        guard let url = URL(string: urlString) else {
            throw CloudError.badURL
        }
        let storageRef = Storage.storage().reference(forURL: urlString)
        let data = try await storageRef.data(maxSize: 5 * 1024 * 1024)
        guard let image = UIImage(data: data) else {
            throw CloudError.imageMissing
        }
        return Image(uiImage: image)
    }
}
