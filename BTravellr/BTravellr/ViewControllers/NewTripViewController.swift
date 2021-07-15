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
    
    @IBOutlet weak var carBut: UIButton!
//    @IBOutlet weak var tbl: UITableView!
//    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var planeBut: UIButton!
    @IBOutlet weak var busBut: UIButton!
    @IBOutlet weak var footBut: UIButton!
    @IBOutlet weak var bikeBut: UIButton!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var tramBut: UIButton!
    @IBOutlet weak var transpLabel: UILabel!
    @IBOutlet weak var boatBut: UIButton!
    
    
    //    let tbl: UITableView = {
//            let v = UITableView(frame: .zero, style: .plain)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            return v
//        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
    
//        view.addSubview(tbl)
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(),  metrics: nil, views: ["v0" : tbl]))
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : tbl]))

        setConstraints()
    }
    func setConstraints(){
        
//        transpLabel.topAnchor.constraint(equalTo: tbl2.bottomAnchor, constant: view.bounds.height*0.08).isActive = true
        
        
        carBut.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.height*0.032).isActive = true
        carBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        carBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        
        planeBut.leftAnchor.constraint(equalTo: carBut.rightAnchor, constant: view.bounds.height*0.03).isActive = true
        planeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        planeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        
        busBut.leftAnchor.constraint(equalTo: planeBut.rightAnchor, constant: view.bounds.height*0.03).isActive = true
        busBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        busBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        
        footBut.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -view.bounds.height*0.032).isActive = true
        footBut.leftAnchor.constraint(equalTo: busBut.rightAnchor, constant: view.bounds.height*0.03).isActive = true
        footBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        footBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        
        bikeBut.leadingAnchor.constraint(equalTo: carBut.centerXAnchor,constant: 0).isActive = true
        bikeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        bikeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        bikeBut.bottomAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: view.bounds.height*0.1).isActive = true
        
        busBut.leftAnchor.constraint(equalTo: planeBut.rightAnchor, constant: view.bounds.height*0.03).isActive = true
        boatBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        boatBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
        
        transpLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        boatBut.bottomAnchor.constraint(equalTo: carLabel.bottomAnchor, constant: view.bounds.height*0.1).isActive = true
        
//        tramBut.leftAnchor.constraint(equalTo: bikeBut.rightAnchor, constant: view.bounds.height*0.03).isActive = true
//        tramBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
//        tramBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1).isActive = true
////        tramBut.centerYAnchor.constraint(equalTo: bikeBut.centerYAnchor, constant: 0).isActive = true
        
//        tbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
}
