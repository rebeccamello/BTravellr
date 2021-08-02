//
//  CollectionViewCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 20/07/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(img)
        img.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
