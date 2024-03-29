//
//  PickedPhotoViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 29/07/21.
//

import UIKit
import Foundation

class PickedPhotoViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var trip: Trip?
    var imageIndex = IndexPath()
    var deleteIndex = 0
    var imageArray = [UIImage]()
    var imageDataArray = [Images]()
    var counter = 0
    var lastDeceleratingOffset: CGFloat = 0
    var dragingOffset: CGFloat = 0
    
    weak var photosDelegate: PickedPhotoDelegate?

    init(trip: Trip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
        let img = (trip.tripPhotos?.array as? [Images])
        imageDataArray = img ?? []
        imageArray = imageDataArray.compactMap{ //mapeia um array em outro, excluindo todos que dao nill
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
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        
        let deletePhoto = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(actDelete))
        navigationItem.rightBarButtonItems = [deletePhoto]
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(FullImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        setConstraints()
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FullImageCell
        cell.imgView.image = imageArray[indexPath.row]
        deleteIndex = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        deleteIndex = indexPath.row
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        updateOffset(offset: &dragingOffset, scrollView: scrollView)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        updateOffset(offset: &lastDeceleratingOffset, scrollView: scrollView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else{return}
        flowLayout.itemSize = collectionView.frame.size
        flowLayout.invalidateLayout()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.scrollToItem(at: imageIndex, at: .left, animated: false)
        deleteIndex = Int(imageIndex.row)
    }
    
    //MARK: Função de deletar
    @objc func actDelete(){
        let alert = UIAlertController(title: "Tem certeza que deseja apagar essa foto?", message: "Será excluída do álbum de fotos da sua viagem", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Excluir", style: .destructive) { [self] (action) in
            let photo = imageDataArray[self.deleteIndex]
            try! CoreDataStack.shared.deleteImage(image: photo)
            photosDelegate?.didRegister(index: deleteIndex)
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    //MARK: Constraints
    func setConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func didOffsetChanged(offset: CGFloat, toPrevious: Bool){
        let minimumScrollValue = self.collectionView.frame.size.width * 0.7
        let previousOffset: CGFloat = toPrevious ? minimumScrollValue : 0
        let contentIndex = Int(round((offset - previousOffset) / minimumScrollValue))
        deleteIndex = abs(contentIndex < imageArray.count ? contentIndex : imageArray.count - 1)
        
        collectionView.scrollToItem(at: IndexPath(item: deleteIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func updateOffset(offset: inout CGFloat, scrollView: UIScrollView){
        let toPrevious: Bool = scrollView.contentOffset.x < offset
        didOffsetChanged(offset: scrollView.contentOffset.x, toPrevious: toPrevious)
        offset = scrollView.contentOffset.x
    }
    
}
