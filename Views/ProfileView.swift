//
//  ProfileView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
            ZStack(alignment: .top) {
                
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    
                    ProfileHeaderView()
                        .padding(.top, -30)
                    
                    ProfilePhotoView()
                    
                }
            }
        }
}

#Preview {
    ProfileView()
}

