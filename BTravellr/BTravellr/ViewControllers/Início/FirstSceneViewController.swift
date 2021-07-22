//
//  ViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit
import CoreData

class FirstSceneViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    let label = UILabel()
    let but2 = UIButton()
    var but: UIBarButtonItem?
    private var collectionView: UICollectionView?
    
    private let coreData = CoreDataStack.shared
    var imgFundo: UIImage = UIImage(named: "collectionBg")!
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        view.backgroundColor = .systemBackground
        title = "Minhas viagens"
        but = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actNewTrip))
        navigationItem.rightBarButtonItem = but!
        
        view.addSubview(label)
        view.addSubview(but2)
        
        if frc.fetchedObjects?.count != 0 {
            label.isHidden = true
        }
        
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
        
        
//        but2.addTarget(self, action: #selector(actTrip), for: .touchDown)
        setConstraints()
    }

    func setConstraints(){
        // textinho de quando ainda nao tem viagens
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ainda não há nenhuma viagem registrada"
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        
        //botao2
        but2.translatesAutoresizingMaskIntoConstraints = false
        but2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        but2.heightAnchor.constraint(equalToConstant: 45).isActive = true
        but2.layer.cornerRadius = 15
        but2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        but2.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 45).isActive = true
        but2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        but2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        but2.setTitle("viagem", for: .normal)
        but2.setTitleColor(.white, for: .normal)
        but2.setTitleColor(.white, for: .highlighted)
        but2.backgroundColor = #colorLiteral(red: 0.2103129625, green: 0.6795147061, blue: 0.6962627769, alpha: 1)
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func actNewTrip() -> Void{
        let root = NewTripViewController()
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
    
//    @objc func actTrip() -> Void{
//        let vc = TripViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    //MARK: CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frc.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TripCollectionViewCell else {preconditionFailure()}
        
        let object = frc.object(at: indexPath)
        cell.img.image = imgFundo
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as? PopUpViewController
//        vc?.pergunta = perguntas[selectedIndex]
//    }

}

extension FirstSceneViewController: NewTripViewControllerDelegate {
    func didRegister() {
        collectionView?.reloadData()
    }
}
