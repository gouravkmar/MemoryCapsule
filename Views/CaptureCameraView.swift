//
//  CaptureCameraView.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 28/03/25.
//

import SwiftUI
import UIKit

struct CameraCaptureView: View {
    @State private var capturedImage: UIImage?
    @State private var isCameraPresented = false
    @Binding var selectedTab: Int
    @State var isCameraCancelled = false
    @State var title: String = ""
    @State var description : String = ""
    @State var shouldShowTitle : Bool = false
    @State var shouldShowDescription : Bool = false
    @State var showTitleView = false
    @State var showDescriptionView = false
    @FocusState private var isTextFieldFocused: Bool
    @State var showLoader = false
    @EnvironmentObject var memoryModel : MemoriesViewModel
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                if let image = capturedImage {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top,50)
                            .onTapGesture {
                                if title.isEmpty {
                                    shouldShowTitle = true
                                }
                                else if !title.isEmpty && !description.isEmpty {
                                    shouldShowTitle = false
                                    shouldShowDescription = false
                                }
                                else if description.isEmpty {
                                    shouldShowDescription = true
                                }
                                
                            }.overlay(alignment: .bottomLeading,content: {
                                VStack{
                                    if showTitleView{
                                        Text(title)
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading,20)
                                            .onTapGesture {
                                                shouldShowTitle = true
                                            }
                                        
                                    }
                                    if showDescriptionView{
                                        Text(description)
                                            .font(.footnote)
                                            .fontWeight(.light)
                                            .foregroundColor(.white)
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading,20)
                                        
                                            .multilineTextAlignment(.leading)
                                            .onTapGesture {
                                                shouldShowDescription = true
                                            }
                                    }
                                }
                            }).overlay(content: {
                                if showLoader{
                                    ZStack{
                                        VStack {
                                            ProgressView()
                                                .scaleEffect(1.5)
                                                .tint(.gray)
                                                .padding()
                                            Text("Uploading Memory")
                                                .foregroundStyle(.white)
                                        }
                                        
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            })
                        if shouldShowDescription || shouldShowTitle {
                            if shouldShowDescription {
                                TextField("Say something to remember...",text: $description)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.8)
                                    .onSubmit {
                                        showDescriptionView = true
                                        shouldShowDescription = false}
                                    .onAppear(perform: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            isTextFieldFocused = true  // Automatically focus on appear
                                        }
                                    })
                                    .focused($isTextFieldFocused)
                            }else {
                                TextField("What's special about this memory?",text: $title)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.8)
                                    .onSubmit {
                                        showTitleView = true
                                        shouldShowTitle = false}
                                    .onAppear(perform: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            isTextFieldFocused = true  // Automatically focus on appear
                                        }
                                    })
                                    .focused($isTextFieldFocused)
                            }
                        }
                    }
                } else {
                    Spacer()
                    Text("Take a photo")
                        .foregroundColor(.gray)
                }
                Spacer()
                if let image = capturedImage , !isTextFieldFocused{
                    HStack{
                        Spacer()
                        Button(action: {
                            isCameraPresented = true
                        }) {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50) // Adjust the size of the camera icon
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white) // Button background color
                                .clipShape(Circle()) // Makes the button round
                                .shadow(radius: 10)
                            
                        }.padding(.trailing,53)
                        
                        Button(
                            action: {
                                Task{
                                    guard let image = capturedImage else { return }
                                    showLoader = true
                                    let memory = await MemoryManager.shared.saveImageToMemory(
                                        image: image,
                                        imageTitle: title,
                                        imageDescription: description
                                    )
                                    showLoader = false
                                    if memory != nil {
                                        DispatchQueue.main.async {
                                            memoryModel.memories?
                                                .insert(memory!, at: 0)
                                        }
                                    }
                                }
                                
                            }
                        ) {
                            Image("upload")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                            
                        }
                        .padding(.trailing,10)
                        
                        
                    }.frame(maxWidth: .infinity)
                        .padding(.bottom,20)
                }
            }
        }
        .onAppear {
            if capturedImage == nil , !isCameraCancelled{
                isCameraPresented = true
            }
        }
        .onChange(of: isCameraCancelled, {
            if capturedImage == nil{
                selectedTab = 0
                isCameraCancelled = false
            }
        })
        .fullScreenCover(isPresented: $isCameraPresented) {
            CameraView(capturedImage: $capturedImage, isCancelled: $isCameraCancelled)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    CameraCaptureView(selectedTab: .constant(1))
}

