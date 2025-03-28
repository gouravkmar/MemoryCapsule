//
//  MemoryCardViewModel.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import SwiftUICore
class MemoryCardViewModel :ObservableObject {
    @Published var memory : Memory
    init(memory: Memory) {
        self.memory = memory
    }
    
    func getImage()->Image{
        if memory.image != nil {
            return memory.image!
        }
        return Image("bojack")
    }
}
