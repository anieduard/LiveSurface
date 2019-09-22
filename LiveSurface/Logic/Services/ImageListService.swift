//
//  ImageListService.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import Foundation
import Combine

class ImageListService: ObservableObject {
    
    @Published
    private(set) var images: [ImageDTO] = []
    
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init() {
        self.url = URL(string: "https://www.livesurface.com/test/api/images.php?key=54a23fe7-d900-48a6-82b9-0b0e87cbd0e3")!
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        cancellable = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap { data, _ in
                let imagesDTO = try JSONDecoder().decode(ImagesDTO.self, from: data)
                return imagesDTO.images
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in print(completion) },
                receiveValue: { [weak self] images in
                    self?.images = images
                }
            )
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
