//
//  MemoryCapsuleTests.swift
//  MemoryCapsuleTests
//
//  Created by Gourav Kumar on 26/03/25.
//

import Testing
import FirebaseCore
import Foundation
@testable import MemoryCapsule

struct MemoryCapsuleTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        try await FireStoreManager.shared
            .saveData(
                Memory(
                    id: "ans",
                    name: "gourav",
                    title: "test",
                    description: "testing",
                    imageURL: "asd",
                    lat: 2345.0,
                    long: 2345.0,
                    timestamp: Date()
                )
            )
    }
    
    @Test func testSaveMemory() async throws {
        if FirebaseApp.app() == nil {
                    FirebaseApp.configure()
                }
            let memory = Memory(
                id: "ans",
                name: "gourav",
                title: "test",
                description: "testing",
                imageURL: "asd",
                lat: 2345.0,
                long: 2345.0,
                timestamp: Date()
            )

            do {
                try await FireStoreManager.shared.saveData(memory)
                print("✅ Memory saved successfully!")
                #expect(true)
            } catch {
                print("❌ Error saving memory: \(error.localizedDescription)")
                #expect(false, "Saving memory should not fail")
            }
        }
    
    @Test("retrieving memory")
    func retrieveMemory() async throws {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        do {
            let data = try await FireStoreManager.shared.fetchData(for: "", lat: 1.0, long: 1.0, radiusMeters: 1.0)
            print(data)
            #expect(true)
        }
        catch {
            print("❌ Error fetching data: \(error.localizedDescription)")
            #expect(false, "Fetching data should not fail")
        }
    }

}
