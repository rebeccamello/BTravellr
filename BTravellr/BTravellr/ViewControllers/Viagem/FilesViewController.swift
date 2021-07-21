////
////  PhotosViewController.swift
////  BTravellr
////
////  Created by Rebecca Mello on 15/07/21.
////
//
//import UIKit
//import MobileCoreServices
//
//class FilesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//    var myUrl = [URL]()
//    private var collectionView: UICollectionView?
//    let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeImage)], in: .import)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        view.backgroundColor = .systemBackground
//        title = "Arquivos"
//        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
//        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actNewFile))
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 300, height: 150) // tamanho das células
//        layout.scrollDirection = .vertical
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        
//        guard let collectionView = collectionView else {
//            return
//        }
//        
//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .clear
//        
//        
//        view.addSubview(collectionView)
//        setConstraints()
//    }
//    
//    @IBAction func actNewFile() -> Void{
//        documentPicker.delegate = self
//        documentPicker.allowsMultipleSelection = true
//        documentPicker.modalPresentationStyle = .fullScreen
//        present(documentPicker, animated: true, completion: nil)
//    }
//    
//    func setConstraints(){
//        collectionView?.translatesAutoresizingMaskIntoConstraints = false
//        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//    }
//    
//    // Quantidade de células
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return myUrl.count
//    }
//    
//    // Customização de células
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell, let data = try? Data(contentsOf: myUrl[indexPath.row])  else {preconditionFailure()}
//        cell.img.image = UIImage(data: data)
//        return cell
//    }
//}
//
//extension FilesViewController: UIDocumentPickerDelegate{
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let selectedFileURL = urls.first else{
//            return
//        }
//        myUrl.append(selectedFileURL)
//        collectionView?.reloadData()
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        
//        // ve se o arquivo ja existe no app
//        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
//        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
//            print("Arquivo já existe")
//        }
//        else{
//            do{
//                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
//                print("Arquivo copiado!")
//            }
//            catch{
//                print("Erro: \(error)")
//            }
//        }
//        
//    }
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        print("teste")
//    }
//}
