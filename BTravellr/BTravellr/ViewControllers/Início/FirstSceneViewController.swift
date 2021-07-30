//
//  ViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit
import CoreData

class FirstSceneViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    let noTripLabel = UILabel()
    var but: UIBarButtonItem?
    private var collectionView: UICollectionView?
    
    private let coreData = CoreDataStack.shared
    var imgFundo: UIImage = UIImage(named: "collectionBg")!
    let plane: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.image = UIImage(named: "HomePlane")
//        theImageView.contentMode = .scaleAspectFit
        return theImageView
    }()
    
    let bags: UIImageView = {
        let theImageView = UIImageView()
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.image = UIImage(named: "bags")
        theImageView.contentMode = .scaleAspectFit
        return theImageView
    }()
    
    private lazy var frc: NSFetchedResultsController<Trip> = {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Trip.name, ascending: false)]

        let frc = NSFetchedResultsController<Trip>(fetchRequest: fetchRequest,
                                                    managedObjectContext: coreData.mainContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        frc.delegate = self
        return frc
    }()

    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        view.backgroundColor = .systemBackground
        title = "Minhas viagens"
        but = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actNewTrip))
        navigationItem.rightBarButtonItem = but!
        
        view.addSubview(noTripLabel)
        view.addSubview(plane)
        view.addSubview(bags)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 150) // tamanho das células
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        do {
            try frc.performFetch()
        } catch {
            print("Não foi")
        }
        
        view.addSubview(collectionView)
        setConstraints()
    }
    
    //MARK: Label de nenhuma viagem
    override func viewWillAppear(_ animated: Bool) {
        reactNumbeOftrips()
    }
    
    func reactNumbeOftrips(){
        if Int(frc.fetchedObjects?.count ?? 1000) != 0 {
            noTripLabel.isHidden = true
            plane.isHidden = true
            bags.isHidden = true
        }
        else{
            noTripLabel.isHidden = false
            plane.isHidden = false
            bags.isHidden = false
        }
    }

    //MARK: Constraints
    func setConstraints(){
        // textinho de quando ainda nao tem viagens
        noTripLabel.translatesAutoresizingMaskIntoConstraints = false
        noTripLabel.text = "Ainda não há nenhuma viagem registrada"
        noTripLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTripLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        
        plane.bottomAnchor.constraint(equalTo: noTripLabel.topAnchor, constant: -20).isActive = true
        plane.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        plane.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        plane.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        plane.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.bounds.height*0.7).isActive = true
        
        bags.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        bags.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bags.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.bounds.height*0.85).isActive = true
        bags.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.bounds.width*0.7).isActive = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //MARK: Função de chamar a controller de Nova Viagem
    @objc func actNewTrip() -> Void{
        let root = NewTripViewController(type: .firstView)
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: {[weak self] in self?.reactNumbeOftrips()})
    }
    
    //MARK: CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfCollections = frc.fetchedObjects?.count ?? 0
        return numberOfCollections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TripCollectionViewCell else {preconditionFailure()}
        
        let object = frc.object(at: indexPath)
        cell.img.image = UIImage(data: object.coverImage ?? Data()) ?? imgFundo
        cell.name.text = object.name
        return cell
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                collectionView?.insertItems(at: [newIndexPath])
            }
        case .delete:
            if let indexPath = indexPath {
                collectionView?.deleteItems(at: [indexPath])
            }
        default:
            break
        }
        collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = frc.object(at: indexPath)
        let vc = TripViewController(tripInfos: object)
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension FirstSceneViewController: NewTripViewControllerDelegate {
    func didRegister() {
        collectionView?.reloadData()
    }
}
