//
//  MemoryManager.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import UIKit
import CoreLocation
class MemoryManager {
    
    static var shared = MemoryManager()
    private init() {
        LocationManager.shared.requestLocationPermission()
    }
    private var memories : [Memory]? = []
    // Save memory with image
    private func saveMemory(_ memory: Memory, image: UIImage) async throws {
        
        let imageURL = try await CloudStorage.shared.uploadImage(image: image)
        var updatedMemory = memory
        updatedMemory.imageURL = imageURL
        try FireStoreManager.shared.saveData(updatedMemory)
        
    }
    
    
    func saveImageToMemory(image : UIImage, imageTitle : String?){

        let id = UUID().uuidString
        let timeStamp = Date()
        Task {
            do {
                let coordinate = try await LocationManager.shared.fetchCurrentLocation()
                
                print("📍 Current Location: \(coordinate.latitude), \(coordinate.longitude)")
                var title = imageTitle
                if title == nil {
                    title = await generateTitle(
                        location: LocationManager.shared.currentLocation
                    )
                }
                let memory = Memory(
                    id: id,
                    name: userName,
                    title: title ?? "",
                    description: nil,
                    imageURL: "",
                    lat: coordinate.latitude,
                    long: coordinate.longitude,
                    timestamp: timeStamp
                )
                try await saveMemory(memory, image: image)
            } catch {
                print("❌ Failed to get location: \(error.localizedDescription)")
            }
        }
    }
    
    private func generateTitle(userName: String? = nil, location: CLLocation?) async -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
            let dateString = dateFormatter.string(from: Date())
            
            var title = "Memory_\(dateString)"
            
            if let userName = userName {
                title = "\(userName)_\(dateString)"
            }
            
            guard let location = location else {
                return title
            }
            
            do {
                let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
                if let city = placemarks.first?.locality {
                    title = "Memory_\(city)"
                }
            } catch {
                print("Reverse geocoding failed: \(error.localizedDescription)")
            }
            return title
    }
    
    func fetchMemoriesForCurrentPlace() async  throws->[Memory]?{
            do {
                let coordinate = try await LocationManager.shared.fetchCurrentLocation()
                print("📍 Current Location: \(coordinate.latitude), \(coordinate.longitude)")
                memories = try await fetchMemoriesWithImage(
                    for: userName,
                    lat: coordinate.latitude,
                    long: coordinate.longitude,
                    radiusMeters: searchRadius
                )
                return memories
            } catch {
                print("❌ Failed to get location: \(error.localizedDescription)")
                throw MemoryError.memoryFetchError
            }
    }
    
    // Fetch all memories for a user
    private func fetchMemoriesWithImage(for userName: String, lat: Double, long: Double, radiusMeters: Double) async throws -> [Memory]?{
        let memories = try await FireStoreManager.shared.fetchData(for: userName, lat: lat, long: long, radiusMeters: radiusMeters)
        var imageMemories = [Memory]()
        for var memory in memories ?? [] {
            memory.image = try? await CloudStorage.shared
                .downloadImage(urlString: memory.imageURL)
            imageMemories.append(memory)
        }
        return imageMemories
        
    }
    
    private func fetchMemories(for userName: String, lat: Double, long: Double, radiusMeters: Double) async throws -> [Memory]?{
        return try await FireStoreManager.shared.fetchData(for: userName, lat: lat, long: long, radiusMeters: radiusMeters)
    }
    
    // Fetch image if needed
    private func fetchImage(for memory: Memory) async throws -> UIImage?{
        return try? await CloudStorage.shared
            .downloadImage(urlString: memory.imageURL)
    }
    
    // Delete memory (optional)
    private func deleteMemory(_ memory: Memory) async throws {
        //implement later
    }

}
enum MemoryError: Error {
    case outOfMemory
    case memoryFetchError
    case memoryStoreError
}
