//
//  MemoryFeedView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import SwiftUI
import Combine
let isTest = true
struct MemoryFeedView: View {
    @StateObject var memoryFeed : MemoryFeedViewModel = .init()
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                MainFeedHeader()
                FeedScroller(memories: memoryFeed.memories!).padding(.top,-60)
                
            }
        }
    }
}

#Preview {
    MemoryFeedView()
}

struct FeedScroller : View {
    var memories : [Memory]
    var body: some View {
        List {
            ForEach(0..<5, content: {_ in
                    MemoryCardView(model: MemoryCardViewModel(memory: Memory.defaultMemory))
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
//            else {
//                if memories.isEmpty {
//                    ForEach(0..<5, content: {_ in
//                        MemoryCardView(model: MemoryCardViewModel(memory: Memory.defaultMemory))
//                            .listRowBackground(Color.clear)
//                    })
//                }else {
//                    ForEach(memories, content: { memory  in
//                        MemoryCardView(model: MemoryCardViewModel(memory: memory))
//                            .listRowBackground(Color.clear)
//                    })
//                }
//            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.black)
    }
}

