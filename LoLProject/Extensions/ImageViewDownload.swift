//
//  ImageDownlow.swift
//  LoLProject
//
//  Created by Антон on 03.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

extension UIImageView {
    func download(urlString: String) {
        var imageURL: URL?
        var image1: UIImage?

        imageURL = URL(string: urlString)
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return (self.image = nil) }
        image1 = UIImage(data: imageData)
        
        return self.image = image1
    }
}
