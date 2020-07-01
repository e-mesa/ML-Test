//
//  ImageRequestService.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation
import Combine
import UIKit.UIImage

final class ImageRequestService: ImageRequestServiceType {
    private let cache: ImageCacheType = ImageCache()
    func loadImage(url: URL) -> AnyPublisher<UIImage?,
                                                  Never> {
        if let image = cache.image(for: url) {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: url)
            })
            .print("Image loading \(url):")
            .eraseToAnyPublisher()
    }

    
    
}
