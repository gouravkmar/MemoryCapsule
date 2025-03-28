//
//  ProfileHeaderView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    let memoriesHere : Int
    var body: some View {
        
        VStack{
            Text("").padding(.top, 30)
            HStack{
                Image("default")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(30)
                    .padding()
                VStack(alignment: .leading){
                    Text("Gourav")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Leaving Memories")
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            HStack {
                VStack{
                    Text("100")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Total")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
                VStack{
                    Text(String(memoriesHere))
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Memories Here")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
            }
        }.padding()
        .frame(maxWidth: .infinity)
        .background(Color.yellow.opacity(0.85))
        .cornerRadius(20)
//        .padding(.horizontal,10)
        .ignoresSafeArea()
//        Spacer()
    }
}

#Preview {
    ProfileHeaderView(memoriesHere: 0)
}
