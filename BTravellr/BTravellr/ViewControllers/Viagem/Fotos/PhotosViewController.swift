//
//  PhotosViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit
import Photos

class PhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var trip: Trip?
    var photos = [Images]()
    var backbutton = UIButton()
    var imgs = [UIImage]()
    var unsavedImgs = [UIImage]()
    
    init(trip: Trip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
        let img = (trip.tripPhotos?.allObjects as? [Images])
        photos = img ?? []
        imgs = photos.compactMap{ //mapeia um array em outro, excluindo todos que dao nill
            guard let data = $0.img else{return nil}
            return UIImage(data: data)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        title = "Fotos"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(callPermition))
        let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(savePhoto))
        
        navigationItem.rightBarButtonItems = [addButton, saveButton]
        backbutton.setTitle("Voltar", for: .normal)
        backbutton.setTitleColor(#colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1), for: .normal)
        backbutton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backbutton.addTarget(self, action: #selector(actBack), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 115, height: 115) // tamanho das células
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
    
    //MARK: Image View
    let imgView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    private var collectionView: UICollectionView?
    
    func actNewImage(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let image = UIImagePickerController()
            image.delegate = self;
            image.sourceType = .photoLibrary
            self.present(image, animated: true, completion: nil)
        }
    }
    
    //MARK: Image Picker
    
    @objc func callPermition(){
        checkPermission()
    }
    
    @objc func checkPermission(){
        let photoAutorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAutorizationStatus{
        case.authorized:
            self.actNewImage()
            print("Acesso permitido pelo usuário")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                DispatchQueue.main.async {
                    print("Status is \(newStatus)")
                    if newStatus == PHAuthorizationStatus.authorized{
                        self.actNewImage()
                        print("Acesso autorizado")
                    }
                }
            })
            print("It is not determined until now")
        case .restricted:
            print("User did not have access to photo album")
        case .denied:
            print("User has denied permission")
            break
        case .limited:
            break
        @unknown default:
            break
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
    
    //MARK: Constraints
    func setConstraints(){
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.2).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4).isActive = true
    }
    
    //MARK: CollectionView
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PickedPhotoViewController()
        vc.imageArray = self.imgs
        vc.imageIndex = indexPath
        print(indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: Ações dos botões
    @objc func savePhoto(){
        for i in 0..<unsavedImgs.count{ // passa pelo vetor das imagens
            if let imageData = unsavedImgs[i].pngData(){ // converte a imagem em data
                _ = try? CoreDataStack.shared.saveImage(data: imageData, trip: trip!)
                alert()
            }
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "Imagens salvas", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    
    @objc func actBack(){
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
