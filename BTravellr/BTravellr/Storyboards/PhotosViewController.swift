//
//  PhotosViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

class PhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let button = UIButton()
    
    let imgView: UIImageView = {
           let theImageView = UIImageView()
           theImageView.translatesAutoresizingMaskIntoConstraints = false
           return theImageView
    }()
    
    
    @objc func actNewImage(_ sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let image = UIImagePickerController()
            image.delegate = self;
            image.sourceType = .photoLibrary
            self.present(image, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            imgView.image = image
            self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actNewImage))
        title = "Fotos"
        
        view.addSubview(imgView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(actNewImage), for: .touchDown)
        setConstraints()
    }
    
    func setConstraints(){
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.2).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        //botao
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 15
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 45).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.2103129625, green: 0.6795147061, blue: 0.6962627769, alpha: 1)
    }
}
