//
//  ImageRequestServiceType.swift
//  ML Test
//
//  Created by Emiliano on 6/29/20.
//

import Foundation
import Combine
import UIKit.UIImage

protocol ImageRequestServiceType: AnyObject {
    func loadImage(url: URL) -> AnyPublisher<UIImage?, Never>
}

