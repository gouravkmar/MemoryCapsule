//
//  MemoryFeedViewModel.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation

class MemoriesViewModel : ObservableObject {
    @Published var memories: [Memory]? 
    
    init() {
        LocationManager.shared.requestLocationPermission()
        LocationManager.shared.requestLocation(completion: {
            self.fetchMemories()
        })
    }
    func fetchMemories() {
        Task {
            do {
                if let memories = try await MemoryManager.shared.fetchMemoriesForCurrentPlace(){
                    DispatchQueue.main.async {
                        self.memories = memories
                    }
                    let imageMemories = try await MemoryManager.shared.fetchImageForMemories(
                        memories: memories
                    )
                    DispatchQueue.main.async {
                        self.memories = imageMemories
                    }
                }
                
            }catch {
                print("Memory fetch error:- \(error.localizedDescription)")
            }
        }
    }
}
