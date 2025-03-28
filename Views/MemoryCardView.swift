//
//  MemoryCardView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import SwiftUI
import Combine

struct MemoryCardView: View {
    @ObservedObject var model: MemoryCardViewModel
    
    var body: some View {
        VStack{
            if let image = model.memory.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.black)
                    .cornerRadius(10)
            }else {
                ZStack {
                    Color.gray.opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                        .frame(height: 500)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
            HStack{
                Image("user")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text( "\(userName): \(model.memory.title)")
                    .foregroundStyle(.white)
                    .font(.system(size: 15,weight: .light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            Text(model.memory.description ?? "")
                .foregroundStyle(.white)
                .font(.system(size: 12,weight: .light))
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading,10)
        }
        //        .padding(.vertical)
        .background(Color.black)
    }
    
}

#Preview {
    MemoryCardView(
        model: MemoryCardViewModel.init(memory: Memory.defaultMemory
                                       )
    )
}
