//
//  MainFeedHeaderViewModel.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 28/03/25.
//

import Foundation
import SwiftUICore

class MainFeedHeaderViewModel : ObservableObject{
    @Published var imageURL : String
    @Published var cityName : String
    init(){
        imageURL = "https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png"
        cityName = ""
        fetchHeaderImage()
    }
    func fetchHeaderImage(){
        Task{
            let cityName = await MemoryManager.shared.getCityName()
            DispatchQueue.main.async{
                self.cityName = cityName
            }
        }
    }
}
