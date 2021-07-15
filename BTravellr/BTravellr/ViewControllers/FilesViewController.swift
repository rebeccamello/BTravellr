//
//  PhotosViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

class FilesViewController: UIViewController {
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        view.addSubview(titleLabel)
        
        titleLabel.text = "Fotos"
    }
    
    func setConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
