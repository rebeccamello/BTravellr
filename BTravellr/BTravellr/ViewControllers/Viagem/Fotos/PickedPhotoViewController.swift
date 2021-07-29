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
        theImageView.image = UIImage(named: "Aviao1")
        theImageView.contentMode = .scaleAspectFit
        return theImageView
    }()
    
    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        
        view.addSubview(imgView)
        
        let deletePhoto = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(actDelete))
        navigationItem.rightBarButtonItems = [deletePhoto]
        
        setConstraints()
    }
    
    //MARK: Função de deletar
    @objc func actDelete(){
        let alert = UIAlertController(title: "Tem certeza que deseja apagar essa foto?", message: "Será excluída do álbum de fotos da sua viagem", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Excluir", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    //MARK: Constraints
    func setConstraints(){
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.bounds.height*0.95).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
