//
//  MemoryManager.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import UIKit
import CoreLocation
import SwiftUICore
class MemoryManager {
    
    static var shared = MemoryManager()
    private init() {
        LocationManager.shared.requestLocationPermission()
    }
    private var memories : [Memory]? = []
    var cityName : String?
    // Save memory with image
    private func saveMemory(_ memory: Memory, image: UIImage) async throws->Memory? {
        
        let imageURL = try await CloudStorage.shared.uploadImage(image: image)
        var updatedMemory = memory
        updatedMemory.imageURL = imageURL
        try FireStoreManager.shared.saveData(updatedMemory)
        return updatedMemory
        
    }
    
    
    
    func saveImageToMemory(image : UIImage, imageTitle : String,imageDescription : String)async ->Memory?{

        let id = UUID().uuidString
        let timeStamp = Date()
            do {
                let coordinate = try await LocationManager.shared.fetchCurrentLocation()
                
                print("📍 Current Location: \(coordinate.latitude), \(coordinate.longitude)")
                var title = imageTitle
                let titleString =  await generateTitle(
                    location: LocationManager.shared.currentLocation
                )
                var description = imageDescription
                if title == "" {
                    title = titleString
                }else if description == ""{
                    description = titleString
                }
                let memory = Memory(
                    id: id,
                    name: userName,
                    title: title,
                    description: description,
                    imageURL: "",
                    lat: coordinate.latitude,
                    long: coordinate.longitude,
                    timestamp: timeStamp,
                    image: Image(uiImage: image)
                )
                let updatedMemory = try await saveMemory(memory, image: image)
                return updatedMemory
            } catch {
                print("❌ Failed to get location: \(error.localizedDescription)")
                return nil
            }
    }
    
    func getCityName()async ->String {
        let location = LocationManager.shared.currentLocation
        guard let location = location else {
            return "India"
        }
        do {
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
            if let city = placemarks.first?.locality {
                return city
            }
        }
        catch{
            return "India"
        }
        return "India"
    }
    
    private func generateTitle(userName: String? = nil, location: CLLocation?) async -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMMMYYYY" // Format: 12April2023
            dateFormatter.locale = Locale(identifier: "en_US") // Ensures month names are in English
            let dateString = dateFormatter.string(from: Date())
            
            var title = "Memory on \(dateString)"
            let cityName: String = await getCityName()
            title = "\(title) in \(cityName)"
            return title
    }
    
    
    func fetchMemoriesForCurrentPlace() async  throws->[Memory]?{
            do {
                guard let coordinate = LocationManager.shared.currentLocation?.coordinate else {return nil}
                print("📍 Current Location: \(coordinate.latitude), \(coordinate.longitude)")
                let memories = try await fetchMemories(
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
    

    private func fetchMemories(for userName: String, lat: Double, long: Double, radiusMeters: Double) async throws -> [Memory]? {
        let memories = try await FireStoreManager.shared.fetchData(for: userName, lat: lat, long: long, radiusMeters: radiusMeters) ?? []
        return memories.sorted { $0.timestamp > $1.timestamp }
    }
    func fetchImageForMemories(memories : [Memory])async throws -> [Memory]?
    {
        return try await withThrowingTaskGroup(of: Memory.self) { group in
            for var memory in memories {
                group.addTask {
                    print("downloading image named : \(memory.imageURL)")
                    var updatedMemory = memory
                    updatedMemory.image = try? await CloudStorage.shared.downloadImage(urlString: memory.imageURL)
                    print("downloaded image named : \(memory.imageURL)")
                    return updatedMemory
                }
            }
            
            var imageMemories = [Memory]()
            for try await memory in group {
                imageMemories.insert(memory, at: 0)
            }
            
            return imageMemories.sorted { $0.timestamp > $1.timestamp }
        }
        
    }


    
//    private func fetchMemories(for userName: String, lat: Double, long: Double, radiusMeters: Double) async throws -> [Memory]?{
//        return try await FireStoreManager.shared.fetchData(for: userName, lat: lat, long: long, radiusMeters: radiusMeters)
//    }
    
    // Fetch image if needed
    private func fetchImage(for memory: Memory) async throws -> Image?{
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
