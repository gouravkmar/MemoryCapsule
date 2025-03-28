//
//  TabView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab : Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            MemoryFeedView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            CameraCaptureView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }.tag(1)
            ProfileView()
                .tabItem {
                Image(systemName: "person.circle")
                Text("Profile")
            }.tag(2)

        }.toolbarBackground(Color.white)
    }
}

#Preview {
    MainTabView()
}
