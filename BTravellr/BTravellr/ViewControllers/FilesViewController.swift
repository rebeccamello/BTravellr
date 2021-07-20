//
//  PhotosViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit
import MobileCoreServices

class FilesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Arquivos"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actNewFile))
    }
    
    @IBAction func actNewFile() -> Void{
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
           documentPicker.delegate = self
           documentPicker.allowsMultipleSelection = false
           documentPicker.modalPresentationStyle = .fullScreen
           present(documentPicker, animated: true, completion: nil)
    }
    
    func setConstraints(){
        
    }
}

extension FilesViewController: UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else{
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // ve se o arquivo ja existe no app
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
            print("Arquivo já existe")
        }
        else{
            do{
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                print("Arquivo copiado!")
            }
            catch{
                print("Erro: \(error)")
            }
        }
//            guard controller.documentPickerMode == .import, let url = urls.first, let image = UIImage(contentsOfFile: url.path) else { return }
//
//            documentImport(image)
//            controller.dismiss(animated: true)
//        }
//
//        public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//            controller.dismiss(animated: true)
        }
}
