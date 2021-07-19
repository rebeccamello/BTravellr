//
//  ViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit

class FirstSceneViewController: UIViewController{

    let button = UIButton()
    let label = UILabel()
    let but2 = UIButton()
    let barBut = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actNewTrip))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        title = "Minhas viagens"
        navigationItem.rightBarButtonItem  = barBut
        
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(but2)
        barBut.action = #selector(actNewTrip)
        
        button.addTarget(self, action: #selector(actNewTrip), for: .touchDown)
        but2.addTarget(self, action: #selector(actTrip), for: .touchDown)
        setConstraints()
    }

    func setConstraints(){
        // textinho de quando ainda nao tem viagens
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ainda não há nenhuma viagem registrada"
        label.textColor = .black
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        
        //botao
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 15
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 45).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.2103129625, green: 0.6795147061, blue: 0.6962627769, alpha: 1)
        
        //botao2
        but2.translatesAutoresizingMaskIntoConstraints = false
        but2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        but2.heightAnchor.constraint(equalToConstant: 45).isActive = true
        but2.layer.cornerRadius = 15
        but2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        but2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 45).isActive = true
        but2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        but2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        but2.setTitle("viagem", for: .normal)
        but2.setTitleColor(.white, for: .normal)
        but2.setTitleColor(.white, for: .highlighted)
        but2.backgroundColor = #colorLiteral(red: 0.2103129625, green: 0.6795147061, blue: 0.6962627769, alpha: 1)
    }
    
    @objc func actNewTrip() -> Void{
        let root = NewTripViewController()
        let vc = UINavigationController(rootViewController: root)
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }
    
    @objc func actTrip() -> Void{
        let vc = TripViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

