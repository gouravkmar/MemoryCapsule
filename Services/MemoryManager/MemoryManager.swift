//
//  MemoryManager.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import UIKit
class MemoryManager {
    
    static var shared = MemoryManager()
    private init() {}
    private let memories : [Memory] = []
    // Save memory with image
    func saveMemory(_ memory: Memory, image: UIImage) async throws {
        
        let imageURL = try await CloudStorage.shared.uploadImage(image: image)
        var updatedMemory = memory
        updatedMemory.imageURL = imageURL
        try FireStoreManager.shared.saveData(updatedMemory)
        
    }
    
    // Fetch all memories for a user
    func fetchMemoriesWithImage(for userName: String, lat: Double, long: Double, radiusMeters: Double) async throws -> [Memory]?{
        let memories = try await FireStoreManager.shared.fetchData(for: userName, lat: lat, long: long, radiusMeters: radiusMeters)
        var imageMemories = [Memory]()
        for var memory in memories ?? [] {
            memory.image = try? await CloudStorage.shared
                .downloadImage(urlString: memory.imageURL)
            imageMemories.append(memory)
        }
        return imageMemories
        
    }
    
    func fetchMemories(for userName: String, lat: Double, long: Double, radiusMeters: Double) async throws -> [Memory]?{
        return try await FireStoreManager.shared.fetchData(for: userName, lat: lat, long: long, radiusMeters: radiusMeters)
    }
    
    // Fetch image if needed
    func fetchImage(for memory: Memory) async throws -> UIImage?{
        return try? await CloudStorage.shared
            .downloadImage(urlString: memory.imageURL)
    }
    
    // Delete memory (optional)
    func deleteMemory(_ memory: Memory) async throws {
        //implement later
    }

}
