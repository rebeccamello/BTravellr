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
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var name: UILabel = {
        let titulo = UILabel()
        titulo.textColor = .white
//        titulo.backgroundColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 18.0)
        return titulo
    }()
    
    var background: UILabel = {
        let bg = UILabel()
        bg.backgroundColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        bg.text = " "
        bg.font = UIFont.boldSystemFont(ofSize: 20.0)
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(img)
        self.addSubview(background)
        self.addSubview(name)

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        
        img.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        name.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 5).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
