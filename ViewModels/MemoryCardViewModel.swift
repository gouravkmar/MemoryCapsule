//
//  MemoryCardViewModel.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import UIKit
class MemoryCardViewModel :ObservableObject {
    @Published var memory : Memory
    init(memory: Memory) {
        self.memory = memory
    }
    
    func getImage()->UIImage{
        if memory.image != nil {
            return memory.image!
        }
        return UIImage(named: "bojack")!
    }
}
