//
//  ContentView.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    private var imageListService: ImageListService
    
    init(imageListService: ImageListService) {
        self.imageListService = imageListService
    }
    
    var body: some View {
        NavigationView {
//            CollectionView(imageListService.images) { imageDTO in
            List(imageListService.images) { imageDTO in
//                NavigationButton(destination: ImageDetailView(url: url)) {
                        URLImage(imageName: imageDTO.image)
                            .frame(minWidth: 100.0, maxWidth: 100.0, minHeight: 100.0, maxHeight: 100.0)
                            .clipped()
//                }
            }
            .navigationBarTitle(Text("Images"))
        }
        .onAppear(perform: imageListService.load)
        .onDisappear(perform: imageListService.cancel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageListService: ImageListService())
    }
}
