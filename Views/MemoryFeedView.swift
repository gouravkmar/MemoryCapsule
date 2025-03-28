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
    @EnvironmentObject var memoryModel : MemoriesViewModel
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                MainFeedHeader()
                if let memories = memoryModel.memories {
                    // add empty view
                    FeedScroller(memories: memories).padding(.top,-60)
                }else {
                    ZStack{
                        VStack {
                            ProgressView()
                                .scaleEffect(1.5)
                                .tint(.gray)
                                .padding()
                            Text("Fetching Memories...")
                                .foregroundStyle(.white)
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                
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
//            ForEach(0..<5, content: {_ in
//                MemoryCardView(model: MemoryCardViewModel(memory: Memory.defaultMemory))
//                    .listRowBackground(Color.clear)
//                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//            })
            ForEach(memories, content: { memory  in
                MemoryCardView(model: MemoryCardViewModel(memory: memory))
                    .listRowBackground(Color.clear)
            })
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.black)
    }
}

