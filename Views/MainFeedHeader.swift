//
//  MainFeedHeader.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 28/03/25.
//

import SwiftUI

struct MainFeedHeader: View {
    @ObservedObject var viewModel = MainFeedHeaderViewModel()
    var body: some View {
        HStack{
            Text(viewModel.cityName)
                .font(.system(size: 30))
                .fontWeight(.semibold)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity,alignment: .leading)
            AsyncImage(url: URL(string: viewModel.imageURL)) { image in
                image.resizable()
                    .frame(width: 40, height: 40,alignment: .trailing)
                    .clipShape(Circle())
                    .padding(.trailing,20)
            } placeholder: {
                Image("user")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 40, height: 40,alignment: .trailing)
                    .clipShape(Circle())
                    .padding(.trailing,20)
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.top,40)
        .background(Color.blue.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .ignoresSafeArea()
        Spacer()
    }
}

#Preview {
    MainFeedHeader()
}
