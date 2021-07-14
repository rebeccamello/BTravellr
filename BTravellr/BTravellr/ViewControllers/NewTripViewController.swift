//
//  NewTripViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit

class NewTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let textos = ["Nome", "Destino"]
    let text2 = ["Ida", "Volta"]
    
    @IBOutlet weak var carBut: UIButton!
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var planeBut: UIButton!
    @IBOutlet weak var busBut: UIButton!
    @IBOutlet weak var footBut: UIButton!
    @IBOutlet weak var bikeBut: UIButton!
    
    
    //    let tbl: UITableView = {
//            let v = UITableView(frame: .zero, style: .plain)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            return v
//        }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        cell.textLabel?.text = textos[indexPath.row]
        cell.textLabel?.textColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
    
//        view.addSubview(tbl)
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(),  metrics: nil, views: ["v0" : tbl]))
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : tbl]))
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tbl2.delegate = self
        tbl2.dataSource = self
        tbl2.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        setConstraints()
    }
    func setConstraints(){
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
        
        bikeBut.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.height*0.08).isActive = true
        bikeBut.heightAnchor.constraint(equalToConstant: view.bounds.height*0.08).isActive = true
        bikeBut.widthAnchor.constraint(equalToConstant: view.bounds.height*0.08).isActive = true
        
//        tbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
}
