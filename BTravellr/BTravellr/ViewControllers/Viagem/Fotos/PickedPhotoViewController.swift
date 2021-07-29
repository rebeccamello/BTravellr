//
//  PickedPhotoViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 29/07/21.
//

import UIKit

class PickedPhotoViewController: UIViewController, UINavigationControllerDelegate {
    
    var trip: Trip?
    let imgView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    override func viewDidLoad() {
        title = "Fotos"
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imgView)
        setConstraints()
    }
    func setConstraints(){
        imgView.backgroundColor = .red
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
