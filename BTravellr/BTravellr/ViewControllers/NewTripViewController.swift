//
//  NewTripViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit

class NewTripViewController: UIViewController{
    let textos = ["Nome", "Destino"]
    let text2 = ["Ida", "Volta"]
    let barBut = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(actHome))
    
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
    
    
//    @IBOutlet weak var tbl: UITableView!
//    @IBOutlet weak var tbl2: UITableView!

    
    
    //    let tbl: UITableView = {
//            let v = UITableView(frame: .zero, style: .plain)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            return v
//        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        title = "Nova viagem"
        navigationItem.rightBarButtonItem  = barBut
        
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
        
    
//        view.addSubview(tbl)
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(),  metrics: nil, views: ["v0" : tbl]))
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : tbl]))
        setButtons()
        setConstraints()
    }
    
    @IBAction func actHome() -> Void{
        let root = FirstSceneViewController()
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
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
    
    func setConstraints(){
        
        // Meios de Transportes
        transpLabel.translatesAutoresizingMaskIntoConstraints = false
        transpLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        transpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        transpLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        transpLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Botoes
        carBut.translatesAutoresizingMaskIntoConstraints = false
        carBut.topAnchor.constraint(equalTo: transpLabel.bottomAnchor, constant: 20).isActive = true
        carBut.trailingAnchor.constraint(equalTo: planeBut.leadingAnchor, constant: -view.bounds.height*0.035).isActive = true
        carBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        carBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        planeBut.translatesAutoresizingMaskIntoConstraints = false
        planeBut.centerYAnchor.constraint(equalTo: carBut.centerYAnchor).isActive = true
        planeBut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.height*0.06).isActive = true
        planeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        planeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        busBut.translatesAutoresizingMaskIntoConstraints = false
        busBut.centerYAnchor.constraint(equalTo: carBut.centerYAnchor).isActive = true
        busBut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.height*0.05).isActive = true
        busBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        busBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        footBut.translatesAutoresizingMaskIntoConstraints = false
        footBut.centerYAnchor.constraint(equalTo: carBut.centerYAnchor).isActive = true
        footBut.leadingAnchor.constraint(equalTo: busBut.trailingAnchor, constant: view.bounds.height*0.035).isActive = true
        footBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        footBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        boatBut.translatesAutoresizingMaskIntoConstraints = false
        boatBut.centerYAnchor.constraint(equalTo: bikeBut.centerYAnchor).isActive = true
        boatBut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        boatBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        boatBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        bikeBut.translatesAutoresizingMaskIntoConstraints = false
        bikeBut.trailingAnchor.constraint(equalTo: boatBut.leadingAnchor,constant: -view.bounds.height*0.04).isActive = true
        bikeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        bikeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        bikeBut.topAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: view.bounds.height*0.05).isActive = true
        
        
        tramBut.translatesAutoresizingMaskIntoConstraints = false
        tramBut.centerYAnchor.constraint(equalTo: bikeBut.centerYAnchor).isActive = true
        tramBut.leadingAnchor.constraint(equalTo: boatBut.trailingAnchor, constant: view.bounds.height*0.04).isActive = true
        tramBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        tramBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.075).isActive = true
        
        // Labels
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        carLabel.topAnchor.constraint(equalTo: carBut.bottomAnchor, constant: 5).isActive = true
        carLabel.centerXAnchor.constraint(equalTo: carBut.centerXAnchor, constant: 0).isActive = true
        carLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        planeLabel.translatesAutoresizingMaskIntoConstraints = false
        planeLabel.topAnchor.constraint(equalTo: planeBut.bottomAnchor, constant: 5).isActive = true
        planeLabel.centerXAnchor.constraint(equalTo: planeBut.centerXAnchor, constant: 0).isActive = true
        planeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        busLabel.translatesAutoresizingMaskIntoConstraints = false
        busLabel.topAnchor.constraint(equalTo: busBut.bottomAnchor, constant: 5).isActive = true
        busLabel.centerXAnchor.constraint(equalTo: busBut.centerXAnchor, constant: 0).isActive = true
        busLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        footLabel.translatesAutoresizingMaskIntoConstraints = false
        footLabel.topAnchor.constraint(equalTo: footBut.bottomAnchor, constant: 5).isActive = true
        footLabel.centerXAnchor.constraint(equalTo: footBut.centerXAnchor, constant: 0).isActive = true
        footLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bikeLabel.translatesAutoresizingMaskIntoConstraints = false
        bikeLabel.topAnchor.constraint(equalTo: bikeBut.bottomAnchor, constant: 5).isActive = true
        bikeLabel.centerXAnchor.constraint(equalTo: bikeBut.centerXAnchor, constant: 0).isActive = true
        bikeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        boatLabel.translatesAutoresizingMaskIntoConstraints = false
        boatLabel.topAnchor.constraint(equalTo: boatBut.bottomAnchor, constant: 5).isActive = true
        boatLabel.centerXAnchor.constraint(equalTo: boatBut.centerXAnchor, constant: 0).isActive = true
        boatLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tramLabel.translatesAutoresizingMaskIntoConstraints = false
        tramLabel.topAnchor.constraint(equalTo: tramBut.bottomAnchor, constant: 5).isActive = true
        tramLabel.centerXAnchor.constraint(equalTo: tramBut.centerXAnchor, constant: 0).isActive = true
        tramLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
