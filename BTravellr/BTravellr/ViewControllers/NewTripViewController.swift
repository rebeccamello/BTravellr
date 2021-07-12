//
//  NewTripViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit

class NewTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let textos = ["Nome", "Destino"]
    let tbl: UITableView = {
            let v = UITableView(frame: .zero, style: .plain)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!

        cell.textLabel?.text = textos[indexPath.row]
        cell.textLabel?.textColor = .gray
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
    
        view.addSubview(tbl)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(),  metrics: nil, views: ["v0" : tbl]))

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : tbl]))
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        setConstraints()
    }
    func setConstraints(){
        tbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
}
