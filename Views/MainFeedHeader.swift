//
//  MainFeedHeader.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 28/03/25.
//

import SwiftUI

struct MainFeedHeader: View {
    var body: some View {
        HStack{
            Text("Mumbai")
                .font(.system(size: 30))
                .fontWeight(.semibold)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity,alignment: .leading)
            Image("user")
                .resizable(resizingMode: .stretch)
                .frame(width: 40, height: 40,alignment: .trailing)
                .clipShape(Circle())
                .padding(.trailing,20)
        }
        .frame(maxWidth: .infinity)
        .padding(.top,40)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .ignoresSafeArea()
        Spacer()
    }
}

#Preview {
    MainFeedHeader()
}
