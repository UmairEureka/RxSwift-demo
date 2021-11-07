//
//  UIImageView+.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func um_downloadImage(urlString: String, placeHolderImage: UIImage){
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
    
}
