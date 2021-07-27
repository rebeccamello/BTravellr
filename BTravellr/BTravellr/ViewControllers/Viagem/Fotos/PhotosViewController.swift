//
//  PhotosViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

class PhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var trip: Trip?
    var photos = [Images]()
    
    init(trip: Trip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
        let img = (trip.tripPhotos?.allObjects as? [Images])
        photos = img ?? []
        imgs = photos.compactMap{ //mapeia um array em outro, excluindo todo que dao nill
            guard let data = $0.img else{return nil}
            return UIImage(data: data)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imgs = [UIImage]()
    var unsavedImgs = [UIImage]()
    
    let imgView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    private var collectionView: UICollectionView?
    
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
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgs.append(image)
        unsavedImgs.append(image)
        collectionView?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        title = "Fotos"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actNewImage))
        let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(savePhoto))
        
        navigationItem.rightBarButtonItems = [addButton, saveButton]
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 150) // tamanho das células
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        
        view.addSubview(collectionView)
        
        view.addSubview(imgView)
        setConstraints()
    }
    
    func setConstraints(){
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.2).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // Quantidade de células
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    // Customização de células
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {preconditionFailure()}
        cell.img.image = imgs[indexPath.row]
        return cell
    }
    
    @objc func savePhoto(){
        for i in 0..<unsavedImgs.count{ // passa pelo vetor das imagens
            if let imageData = unsavedImgs[i].pngData(){ // converte a imagem em data
                _ = try? CoreDataStack.shared.saveImage(data: imageData, trip: trip!)
            }
        }
    }
}
