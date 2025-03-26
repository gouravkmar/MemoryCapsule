//
//  FireStoreManager.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 26/03/25.
//

import Foundation
import FirebaseFirestore
class FireStoreManager {
    static let shared = FireStoreManager()
    private let db = Firestore.firestore()
    private let collectionName = "Memories"
    private init() {}
    
    func fetchData(for userName : String , lat : Double, long : Double, radiusMeters : Double) async throws -> [Memory]?{
        
        var querry =  db.collection(collectionName)
            .whereField(MemoryFields.name,isEqualTo: userName)
            .order(by: MemoryFields.timestamp,descending: true)
        
        let latDelta = radiusMeters * scaleFactor / 111_000.0
        let longDelta = radiusMeters * scaleFactor / (111_000.0 * cos(lat * .pi / 180))
        let latScaled = lat * scaleFactor
        let longScaled = long * scaleFactor
        
        let minLat = latScaled - latDelta
        let maxLat = latScaled + latDelta
        let minLong = longScaled - longDelta
        let maxLong = longScaled + longDelta
        
        querry = querry.whereField(MemoryFields.lat, isGreaterThan: minLat)
            .whereField(MemoryFields.lat, isLessThan: maxLat)
            .whereField(MemoryFields.long, isGreaterThan: minLong)
            .whereField(MemoryFields.long, isLessThan: maxLong)
        do {
            let snapshot = try await querry.getDocuments()
            let documents = snapshot.documents
            let memories = documents.compactMap{doc in
                try? doc.data(as: Memory.self)
            }
            return memories
        }catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func saveData(_ memory : Memory)  throws { // should it throw?
        do {
            let documentReference = db.collection(collectionName).document(memory.id)
            try documentReference.setData(from: memory.scaled())
        }catch {
            print(error.localizedDescription)
        }
    }
}


