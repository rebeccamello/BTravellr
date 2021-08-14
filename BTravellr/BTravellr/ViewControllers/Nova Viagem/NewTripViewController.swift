//
//  NewTripViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit

enum ViewControllerType{
    case firstView
    case editView
}

class NewTripViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate{
    
    var trip: Trip?
    weak var delegate: NewTripViewControllerDelegate?
    weak var delegate2: TripViewControllerDelegate?
    let textos = ["Nome da viagem", "Destino"]
    var barBut: UIBarButtonItem?
    var barBut2: UIBarButtonItem?
    var type: ViewControllerType
    
    let transpLabel = UILabel()
    
    //botoes transportes
    let carBut = UIButton()
    let planeBut = UIButton()
    let busBut = UIButton()
    let footBut = UIButton()
    let bikeBut = UIButton()
    let tramBut = UIButton()
    let boatBut = UIButton()
    
    let carLabel = UILabel()
    let planeLabel = UILabel()
    let busLabel = UILabel()
    let footLabel = UILabel()
    let bikeLabel = UILabel()
    let tramLabel = UILabel()
    let boatLabel = UILabel()
    
    init(trip: Trip? = nil, type: ViewControllerType) {
        self.trip = trip
        self.type = type
        if let tripInfo = trip {
            self.trip = tripInfo
        } else{
            self.trip = try? CoreDataStack.shared.createTrip(name: "", destination: "", dataIda: Date(), dataVolta: Date())
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameField: String = ""
    var destinationField: String = ""
    var dataIdaField = Date()
    var dataVoltaField = Date()
    
    //MARK: TableView
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.backgroundColor = .white
            return table
        }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = textos[indexPath.row]
                cell?.dataTextField.tag = indexPath.row
                cell?.dataTextField.addTarget(self, action: #selector(NomeValueChanged), for: .editingChanged)
                cell?.dataTextField.delegate = self
                cell?.dataTextField.text = trip?.name
                return cell ?? UITableViewCell()
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = textos[indexPath.row]
                cell?.dataTextField.tag = indexPath.row
                cell?.dataTextField.addTarget(self, action: #selector(DestinoValueChanged), for: .editingChanged)
                cell?.dataTextField.delegate = self
                cell?.dataTextField.text = trip?.destination
                return cell ?? UITableViewCell()
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.identifier,for: indexPath) as? DatePickerCell
                cell?.textLabel?.text = "Ida"
                cell?.picker.date = trip?.dataIda ?? Date()
                dataIdaField = cell?.picker.date ?? Date()
                cell?.picker.addTarget(self, action: #selector(datePickerIdaValueChanged(_:)), for: .valueChanged)
                return cell ?? UITableViewCell()
                
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.identifier,for: indexPath) as? DatePickerCell
                cell?.textLabel?.text = "Volta"
                cell?.picker.addTarget(self, action: #selector(datePickerVoltaValueChanged(_:)), for: .valueChanged)
                cell?.picker.tag = indexPath.row
                cell?.picker.date = trip?.dataVolta ?? Date()
                dataVoltaField = cell?.picker.date ?? Date()
                return cell ?? UITableViewCell()
                
            default:
                print("Falhou")
            }
        return UITableViewCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TextView
    @objc func NomeValueChanged(_ textField: UITextField){
        nameField = textField.text ?? ""
        dataVoltaField = trip?.dataVolta ?? Date()
        dataIdaField = trip?.dataIda ?? Date()
    }
    
    @objc func DestinoValueChanged(_ textField: UITextField){
        destinationField = textField.text ?? ""
        dataVoltaField = trip?.dataVolta ?? Date()
        dataIdaField = trip?.dataIda ?? Date()
    }
    
    //MARK: DatePickerChanged
    @objc func datePickerIdaValueChanged(_ picker: UIDatePicker){
        dataIdaField = picker.date
        trip?.dataIda = dataIdaField
        dataVoltaField = trip?.dataVolta ?? Date()
    }
    
    @objc func datePickerVoltaValueChanged(_ picker: UIDatePicker){
        dataVoltaField = picker.date
        trip?.dataVolta = dataVoltaField
        dataIdaField = trip?.dataIda ?? Date()
    }

    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Nova viagem"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        
        switch type {
        case .firstView:
            barBut = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(actSave))
            barBut2 = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelHome))
        case .editView:
            barBut = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(actEdit))
            barBut2 = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelTrip))
        }
        
        
        navigationItem.rightBarButtonItem = barBut
        navigationItem.leftBarButtonItem = barBut2!
        
        initTableView()
        
        view.addSubview(transpLabel)
        
        view.addSubview(boatBut)
        view.addSubview(carBut)
        view.addSubview(tramBut)
        view.addSubview(busBut)
        view.addSubview(planeBut)
        view.addSubview(footBut)
        view.addSubview(bikeBut)
        
        view.addSubview(bikeLabel)
        view.addSubview(boatLabel)
        view.addSubview(carLabel)
        view.addSubview(tramLabel)
        view.addSubview(busLabel)
        view.addSubview(planeLabel)
        view.addSubview(footLabel)
        
        setButtons()
        setConstraints()
    }
    
    func initTableView(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "textField")
        tableView.register(DatePickerCell.self, forCellReuseIdentifier: "DatePickerCell")
        tableView.backgroundColor = .systemBackground
        
        // #3
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.bounds.height*0.1),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -35)
        ])
    }
    
    //MARK: Funcoes dos botoes
    @objc func cancelTrip() -> Void{
        guard let trip = self.trip else{return}
        if !nameField.isEmpty && nameField != "" && !destinationField.isEmpty && destinationField != "" {
            try? CoreDataStack.shared.deleteTrip(trip: trip)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelHome() -> Void{
        guard let trip = self.trip else{return}
        try? CoreDataStack.shared.deleteTrip(trip: trip)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func actSave(){
        guard let trip = self.trip else{return}
        if nameField == "" && destinationField == ""{
            try? CoreDataStack.shared.deleteTrip(trip: trip)
            return
        }
        
        trip.name = nameField
        trip.destination = destinationField
        trip.dataIda = dataIdaField
        trip.dataVolta = dataVoltaField
        
        delegate?.didRegister()
        try? CoreDataStack.shared.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func actEdit(){
        if !nameField.isEmpty && nameField != "" {
            trip?.name = nameField
        }
        
        if !destinationField.isEmpty && destinationField != "" {
            trip?.destination = destinationField
        }
        
        if dataIdaField != Date(){
            trip?.dataIda = dataIdaField
        }
        
        if dataVoltaField != Date(){
            trip?.dataVolta = dataVoltaField
        }
        
        delegate2?.reloadData()
        try? CoreDataStack.shared.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Botões
    func setButtons(){
        carBut.setImage(UIImage(named: "carBut"), for: .normal)
        planeBut.setImage(UIImage(named: "planeBut"), for: .normal)
        tramBut.setImage(UIImage(named: "tramBut"), for: .normal)
        bikeBut.setImage(UIImage(named: "bikeBut"), for: .normal)
        footBut.setImage(UIImage(named: "footBut"), for: .normal)
        boatBut.setImage(UIImage(named: "boatBut"), for: .normal)
        busBut.setImage(UIImage(named: "busBut"), for: .normal)
        
        carLabel.text = "Carro"
        planeLabel.text = "Avião"
        busLabel.text = "Ônibus"
        tramLabel.text = "Trem/Metrô"
        footLabel.text = "A pé"
        boatLabel.text = "Navio"
        bikeLabel.text = "Bicicleta/Moto"
        
        transpLabel.text = "Meios de Transportes"
        transpLabel.font = transpLabel.font.withSize(20)
        carLabel.font = carLabel.font.withSize(14)
        planeLabel.font = planeLabel.font.withSize(14)
        tramLabel.font = tramLabel.font.withSize(14)
        busLabel.font = busLabel.font.withSize(14)
        footLabel.font = footLabel.font.withSize(14)
        bikeLabel.font = bikeLabel.font.withSize(14)
        boatLabel.font = boatLabel.font.withSize(14)
    }
    
    //MARK: Constraints
    func setConstraints(){
        
        // Meios de Transportes
//        transpLabel.translatesAutoresizingMaskIntoConstraints = false
        transpLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        transpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        transpLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        transpLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Botoes
//        carBut.translatesAutoresizingMaskIntoConstraints = false
        carBut.topAnchor.constraint(equalTo: transpLabel.bottomAnchor, constant: 20).isActive = true
        carBut.trailingAnchor.constraint(equalTo: planeBut.leadingAnchor, constant: -view.bounds.height*0.035).isActive = true
        carBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        carBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
//        planeBut.translatesAutoresizingMaskIntoConstraints = false
        planeBut.centerYAnchor.constraint(equalTo: carBut.centerYAnchor).isActive = true
        planeBut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.height*0.06).isActive = true
        planeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        planeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
//        busBut.translatesAutoresizingMaskIntoConstraints = false
        busBut.centerYAnchor.constraint(equalTo: carBut.centerYAnchor).isActive = true
        busBut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.height*0.05).isActive = true
        busBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        busBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
//        footBut.translatesAutoresizingMaskIntoConstraints = false
        footBut.centerYAnchor.constraint(equalTo: carBut.centerYAnchor).isActive = true
        footBut.leadingAnchor.constraint(equalTo: busBut.trailingAnchor, constant: view.bounds.height*0.035).isActive = true
        footBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        footBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
//        boatBut.translatesAutoresizingMaskIntoConstraints = false
        boatBut.centerYAnchor.constraint(equalTo: bikeBut.centerYAnchor).isActive = true
        boatBut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        boatBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        boatBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
//        bikeBut.translatesAutoresizingMaskIntoConstraints = false
        bikeBut.trailingAnchor.constraint(equalTo: boatBut.leadingAnchor,constant: -view.bounds.height*0.04).isActive = true
        bikeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        bikeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        bikeBut.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: view.bounds.height*0.05).isActive = true
        
        
//        tramBut.translatesAutoresizingMaskIntoConstraints = false
        tramBut.centerYAnchor.constraint(equalTo: bikeBut.centerYAnchor).isActive = true
        tramBut.leadingAnchor.constraint(equalTo: boatBut.trailingAnchor, constant: view.bounds.height*0.04).isActive = true
        tramBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        tramBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        // Labels
//        carLabel.translatesAutoresizingMaskIntoConstraints = false
        carLabel.topAnchor.constraint(equalTo: carBut.bottomAnchor, constant: 5).isActive = true
        carLabel.centerXAnchor.constraint(equalTo: carBut.centerXAnchor, constant: 0).isActive = true
        carLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        planeLabel.translatesAutoresizingMaskIntoConstraints = false
        planeLabel.topAnchor.constraint(equalTo: planeBut.bottomAnchor, constant: 5).isActive = true
        planeLabel.centerXAnchor.constraint(equalTo: planeBut.centerXAnchor, constant: 0).isActive = true
        planeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        busLabel.translatesAutoresizingMaskIntoConstraints = false
        busLabel.topAnchor.constraint(equalTo: busBut.bottomAnchor, constant: 5).isActive = true
        busLabel.centerXAnchor.constraint(equalTo: busBut.centerXAnchor, constant: 0).isActive = true
        busLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        footLabel.translatesAutoresizingMaskIntoConstraints = false
        footLabel.topAnchor.constraint(equalTo: footBut.bottomAnchor, constant: 5).isActive = true
        footLabel.centerXAnchor.constraint(equalTo: footBut.centerXAnchor, constant: 0).isActive = true
        footLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        bikeLabel.translatesAutoresizingMaskIntoConstraints = false
        bikeLabel.topAnchor.constraint(equalTo: bikeBut.bottomAnchor, constant: 5).isActive = true
        bikeLabel.centerXAnchor.constraint(equalTo: bikeBut.centerXAnchor, constant: 0).isActive = true
        bikeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        boatLabel.translatesAutoresizingMaskIntoConstraints = false
        boatLabel.topAnchor.constraint(equalTo: boatBut.bottomAnchor, constant: 5).isActive = true
        boatLabel.centerXAnchor.constraint(equalTo: boatBut.centerXAnchor, constant: 0).isActive = true
        boatLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        tramLabel.translatesAutoresizingMaskIntoConstraints = false
        tramLabel.topAnchor.constraint(equalTo: tramBut.bottomAnchor, constant: 5).isActive = true
        tramLabel.centerXAnchor.constraint(equalTo: tramBut.centerXAnchor, constant: 0).isActive = true
        tramLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}


