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
    
    weak var delegate: TripViewControllerDelegate?
    let but = UIButton()
    let localLabel = UILabel()
    let idaLabel = UILabel()
    let voltaLabel = UILabel()
    let navBar = UINavigationBar()
    let navItem = UINavigationItem(title: "Anotações")
    var models = [Section]()
    let deleteTrip = UIButton()
    var inputName = UILabel()
    var inputDestination = UILabel()
    var inputDataIda = UILabel()
    var inputDataVolta = UILabel()
    var trip: Trip
    
    init(tripInfos: Trip) {
        self.trip = tripInfos
        super.init(nibName: nil, bundle: nil)
        imgView.image = UIImage(data: trip.coverImage ?? Data())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // tablle view
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TripTableViewCell.self, forCellReuseIdentifier: TripTableViewCell.identifier)
        return table
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(actNewTrip))

        configure()
        
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        view.addSubview(imgView)
        view.addSubview(idaLabel)
        view.addSubview(voltaLabel)
        view.addSubview(localLabel)
        view.addSubview(but)
        view.addSubview(deleteTrip)
        view.addSubview(inputName)
        view.addSubview(inputDestination)
        view.addSubview(inputDataIda)
        view.addSubview(inputDataVolta)
        
        // configurando botoes
        but.setImage(UIImage(named: "plus.circle"), for: .normal)
        but.addTarget(self, action: #selector(actNewImage), for: .touchDown)
        deleteTrip.setTitle("Excluir viagem", for: .normal)
        deleteTrip.setTitleColor(.systemRed, for: .normal)
        deleteTrip.addTarget(self, action: #selector(actAlert), for: .touchDown)
        
        
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        imgView.backgroundColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        setConstraints()
        setInputs()
    }
    
    //MARK: Cover Image
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
        imgView.contentMode = .scaleToFill
        saveCoverImage()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func saveCoverImage(){
        let imageData = imgView.image?.pngData()
        if imgView.image == nil{
            let savedCoverData = (try? CoreDataStack.shared.createCoverImage(data: imageData ?? Data(), trip: trip)) ?? Data()
            let img = UIImage(data: savedCoverData)
            imgView.image = img
        }
        else{
            let savedCoverData = (try? CoreDataStack.shared.editCoverImage(data: imageData ?? Data(), trip: trip)) ?? Data()
            let img = UIImage(data: savedCoverData)
            imgView.image = img
        }
    }
    
    
    //MARK: Alerta
    @objc func actAlert(){
        let alert = UIAlertController(title: "Tem certeza que deseja apagar essa viagem?", message: "Se exclui-la, você perderá todas as informações contidas nela", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Sim", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            _ = try? CoreDataStack.shared.deleteTrip(trip: self.trip)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    //MARK: Table View para páginas
    func configure(){
        models.append(Section(title: "General", options: [
            TripOption(title: "Fotos", icon: UIImage(systemName: "photo"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
            },
//            TripOption(title: "Arquivos", icon: UIImage(systemName: "folder.fill"), iconBackgroundColor: #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)){
//            },
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
            let vc = PhotosViewController(trip: trip)
            navigationController?.pushViewController(vc, animated: true)
        }
        
//        else if (indexPath.row == 1){
//            let vc = FilesViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        }
        
        else if (indexPath.row == 1){
            let vc = MyBagViewController(tripInfos: trip)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        else{
            let vc = NotesViewController(trip: trip)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func actNewTrip() -> Void{
        let root = NewTripViewController(trip: trip)
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
    
    // MARK: Constraints
    func setConstraints(){
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height*0.1).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        but.translatesAutoresizingMaskIntoConstraints = false
        but.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        but.widthAnchor.constraint(equalToConstant: 30).isActive = true
        but.heightAnchor.constraint(equalToConstant: 30).isActive = true
        but.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -10).isActive = true
        
        localLabel.text = "Destino:"
        localLabel.translatesAutoresizingMaskIntoConstraints = false
        localLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        localLabel.topAnchor.constraint(equalTo: inputName.bottomAnchor, constant: 10).isActive = true
        localLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        localLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        idaLabel.text = "Ida:"
        idaLabel.translatesAutoresizingMaskIntoConstraints = false
        idaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        idaLabel.topAnchor.constraint(equalTo: localLabel.bottomAnchor, constant: 10).isActive = true
        idaLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        idaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        voltaLabel.text = "Volta:"
        voltaLabel.translatesAutoresizingMaskIntoConstraints = false
        voltaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        voltaLabel.topAnchor.constraint(equalTo: idaLabel.bottomAnchor, constant: 10).isActive = true
        voltaLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        voltaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: voltaLabel.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        deleteTrip.translatesAutoresizingMaskIntoConstraints = false
        deleteTrip.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteTrip.widthAnchor.constraint(equalToConstant: 200).isActive = true
        deleteTrip.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        deleteTrip.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //inputs
        inputName.translatesAutoresizingMaskIntoConstraints = false
        inputName.font = UIFont.boldSystemFont(ofSize: 20.0)
        inputName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        inputName.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20).isActive = true
        inputName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        inputName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        inputDestination.translatesAutoresizingMaskIntoConstraints = false
        inputDestination.leadingAnchor.constraint(equalTo: localLabel.trailingAnchor, constant: 10).isActive = true
        inputDestination.topAnchor.constraint(equalTo: inputName.bottomAnchor, constant: 10).isActive = true
        inputDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        inputDestination.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        inputDataIda.translatesAutoresizingMaskIntoConstraints = false
        inputDataIda.leadingAnchor.constraint(equalTo: idaLabel.trailingAnchor, constant: 10).isActive = true
        inputDataIda.topAnchor.constraint(equalTo: localLabel.bottomAnchor, constant: 10).isActive = true
        inputDataIda.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        inputDataIda.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        inputDataVolta.translatesAutoresizingMaskIntoConstraints = false
        inputDataVolta.leadingAnchor.constraint(equalTo: voltaLabel.trailingAnchor, constant: 10).isActive = true
        inputDataVolta.topAnchor.constraint(equalTo: idaLabel.bottomAnchor, constant: 10).isActive = true
        inputDataVolta.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        inputDataVolta.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    //MARK: Setando os inputs
    func setInputs(){
        inputName.text = trip.name
        inputDestination.text = trip.destination
        inputDataIda.text = trip.dataIda
        inputDataVolta.text = trip.dataVolta
    }
}

extension TripViewController: TripViewControllerDelegate {
    func reloadData() {
        setInputs()
    }
}
