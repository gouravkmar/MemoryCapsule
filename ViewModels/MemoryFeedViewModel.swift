//
//  MemoryFeedViewModel.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation

class MemoryFeedViewModel : ObservableObject {
    @Published var memories: [Memory]? = []
    
    init() {
//        fetchMemories()
//        LocationManager.shared.requestLocation()
    }
    func fetchMemories() {
        Task {
            do {
                let fetchMemories = try await MemoryManager.shared.fetchMemoriesForCurrentPlace()
                DispatchQueue.main.async {
                    self.memories = fetchMemories
                }
                
            }catch {
                print("Memory fetch error:- \(error.localizedDescription)")
            }
        }
    }
}
