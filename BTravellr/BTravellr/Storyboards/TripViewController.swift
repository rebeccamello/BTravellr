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

class TripViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let imgView: UIImageView = {
           let theImageView = UIImageView()
           theImageView.image = UIImage(named: "TesteImg.png")
           theImageView.translatesAutoresizingMaskIntoConstraints = false
           return theImageView
    }()

    let nameLabel = UILabel()
    let idaLabel = UILabel()
    let voltaLabel = UILabel()
    let navBar = UINavigationBar()
    let navItem = UINavigationItem(title: "Anotações")
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TripTableViewCell.self, forCellReuseIdentifier: TripTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)

        configure()
        
        view.addSubview(tableView)
        view.addSubview(imgView)
        view.addSubview(nameLabel)
        view.addSubview(idaLabel)
        view.addSubview(voltaLabel)
        
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        setConstraints()
    }
    
    func configure(){
        models.append(Section(title: "General", options: [
            TripOption(title: "Fotos", icon: UIImage(systemName: "photo"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
                print("Clicou")
        },
            TripOption(title: "Arquivos", icon: UIImage(systemName: "folder.fill"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
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
        
        else{
            let vc = NotesViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setConstraints(){
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        nameLabel.text = "Noooooome"
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
