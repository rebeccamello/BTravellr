//
//  ViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/07/21.
//

import UIKit

class FirstSceneViewController: UIViewController {
    var label: UILabel = UILabel()

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        view.addSubview(label)
        view.addSubview(button)
//        button.addTarget(self, action: #selector(actNewTrip), for: .touchDown)
        setConstraints()
    }

    func setConstraints(){
        // textinho de quando ainda nao tem viagens
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ainda não há nenhuma viagem registrada"
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        
        //botao
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 240).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 45).isActive = true
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.2103129625, green: 0.6795147061, blue: 0.6962627769, alpha: 1)
    }
    
//    @IBAction func actNewTrip() -> Void{
//        guard let vc = storyboard?.instantiateViewController(identifier: "idNewTrip") as? NewTripViewController else {return}
//        vc.modalPresentationStyle = .automatic
//        vc.modalTransitionStyle = .coverVertical
//        present(vc, animated: true)
//    }

}

