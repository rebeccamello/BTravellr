//
//  TripViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit

struct Section{
    let title: String
    let options: [TripOption]
}

struct TripOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class TripViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    let but = UIButton()
    let nameLabel = UILabel()
    let idaLabel = UILabel()
    let voltaLabel = UILabel()
    let navBar = UINavigationBar()
    let navItem = UINavigationItem(title: "Anotações")
    var models = [Section]()
    
    // tablle view
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TripTableViewCell.self, forCellReuseIdentifier: TripTableViewCell.identifier)
        return table
    }()
    
    // imagem de capa
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
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(actNewTrip))

        configure()
        
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        view.addSubview(imgView)
        view.addSubview(nameLabel)
        view.addSubview(idaLabel)
        view.addSubview(voltaLabel)
        view.addSubview(but)
        but.setImage(UIImage(named: "plus.circle"), for: .normal)
        but.addTarget(self, action: #selector(actNewImage), for: .touchDown)
        
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        imgView.backgroundColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        setConstraints()
    }
    
    func configure(){
        models.append(Section(title: "General", options: [
            TripOption(title: "Fotos", icon: UIImage(systemName: "photo"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
        },
            TripOption(title: "Arquivos", icon: UIImage(systemName: "folder.fill"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
        },
            TripOption(title: "Minha Mala", icon: UIImage(systemName: "bag.fill"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
        },
            TripOption(title: "Anotações", icon: UIImage(systemName: "note"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
        },
            
        ]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TripTableViewCell.identifier,
            for: indexPath
        ) as? TripTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
                
        if (indexPath.row == 0){
            let vc = PhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        else if (indexPath.row == 1){
            let vc = FilesViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        else if (indexPath.row == 2){
            let vc = MyBagViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        else{
            let vc = NotesViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func actNewTrip() -> Void{
        let root = NewTripViewController()
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
    
    func setConstraints(){
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.1).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        but.translatesAutoresizingMaskIntoConstraints = false
        but.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        but.widthAnchor.constraint(equalToConstant: 20).isActive = true
        but.heightAnchor.constraint(equalToConstant: 20).isActive = true
        but.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -10).isActive = true
        
        
        nameLabel.text = "Nome:"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        idaLabel.text = "Ida:"
        idaLabel.translatesAutoresizingMaskIntoConstraints = false
        idaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        idaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        idaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        idaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        voltaLabel.text = "Volta:"
        voltaLabel.translatesAutoresizingMaskIntoConstraints = false
        voltaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        voltaLabel.topAnchor.constraint(equalTo: idaLabel.bottomAnchor, constant: 10).isActive = true
        voltaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        voltaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: voltaLabel.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
