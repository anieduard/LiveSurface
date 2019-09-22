//
//  ImageService.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import UIKit
import Combine

class ImageService: ObservableObject {
    
    enum ImageLoadingError: Error {
        case incorrectData
    }
    
    @Published
    private(set) var image: UIImage?
    
    private let baseURL: URL = URL(string: "https://www.livesurface.com/test/images")!
    private let url: URL
    private let imageName: String
    private var cancellable: AnyCancellable?
    
    private let cache: NSCache<NSString, UIImage> = NSCache()
    
    init(imageName: String) {
        self.url = baseURL.appendingPathComponent(imageName)
        self.imageName = imageName
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        if let image = cache.object(forKey: imageName as NSString) {
            self.image = image
        } else {
            cancellable = URLSession
                .shared
                .dataTaskPublisher(for: url)
                .tryMap { [weak self] data, _ in
                    guard let image = UIImage(data: data) else {
                        throw ImageLoadingError.incorrectData
                    }
                    
                    if let self = self {
                        self.cache.setObject(image, forKey: self.imageName as NSString)
                    }

                    return image
                }
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] image in
                        self?.image = image
                    }
                )
        }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
