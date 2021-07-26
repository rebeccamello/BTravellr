//
//  CollectionViewCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 20/07/21.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    var name: UILabel = {
        let titulo = UILabel()
        titulo.textColor = .white
        titulo.backgroundColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = titulo.font.withSize(18)
        return titulo
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(img)
        self.addSubview(name)
        
        img.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
