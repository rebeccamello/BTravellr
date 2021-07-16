//
//  MyBagViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 16/07/21.
//

import UIKit

class MyBagViewController: UIViewController {
//    struct Ocean: Identifiable, Hashable {
//        let name: String
//        let id = UUID()
//    }
//    private var oceans = [
//        Ocean(name: "Pacific"),
//        Ocean(name: "Atlantic"),
//        Ocean(name: "Indian"),
//        Ocean(name: "Southern"),
//        Ocean(name: "Arctic")
//    ]
//
//    @State private var multiSelection = Set<UUID>()
//
//    var body: some MyBagViewController {
//        NavigationView {
//            List(oceans, selection: $multiSelection) {
//                Text($0.name)
//            }
//            .navigationTitle("Oceans")
//            .toolbar { EditButton() }
//        }
//        Text("\(multiSelection.count) selections")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.9416348338, green: 0.9360371232, blue: 0.9459378123, alpha: 1)
        
        title = "Minha Mala"
    }
    
    func setConstraints(){
        
    }
}
