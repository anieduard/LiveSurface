//
//  URLImage.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import SwiftUI
import Combine

struct URLImage: View {
    
    @ObservedObject
    private var imageService: ImageService
    
    private let imageName: String
    private let placeholder: Image
    
    var body: some View {
        VStack {
            if imageService.image != nil {
                Image(uiImage: imageService.image!)
                    .resizable()
            } else {
                placeholder
            }
            
            Text(imageName)
        }
        .onAppear(perform: imageService.load)
        .onDisappear(perform: imageService.cancel)
    }
    
    init(imageName: String, placeholder: Image = Image(systemName: "photo")) {
        self.imageService = ImageService(imageName: imageName)
        self.imageName = imageName
        self.placeholder = placeholder
    }
}
