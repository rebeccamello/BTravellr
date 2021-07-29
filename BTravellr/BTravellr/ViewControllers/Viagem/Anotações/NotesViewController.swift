//
//  NotesViewController.swift
//  BTravellr
//
//  Created by Rebecca Mello on 15/07/21.
//

import UIKit
import Combine

class NotesViewController: UIViewController{
    let textView = UITextView()
    var trip: Trip?
    var note: Notes?
    var saveBut: UIBarButtonItem?
    var cancellables = Set <AnyCancellable>()
    var backbutton = UIButton()

    init(trip: Trip) {
        self.trip = trip
        self.note = trip.tripNotes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Anotações"
        view.addSubview(textView)
        if let note = note{
            textView.text = note.text
        }
        
        saveBut = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItem = saveBut
        
        backbutton.setTitle("Voltar", for: .normal)
        backbutton.setTitleColor(#colorLiteral(red: 0.2193259299, green: 0.719204247, blue: 0.7399962544, alpha: 1), for: .normal)
        backbutton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backbutton.addTarget(self, action: #selector(actBack), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
//        backbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(actBack))
//        backbutton?.title = "Voltar"
//        navigationItem.leftBarButtonItem = backbutton
        
        setConstraints()
        
        //Salvar quando para de escrever
        NotificationCenter.default.publisher(for: UITextView.textDidEndEditingNotification)
            .sink(receiveValue: {[weak self] _ in self?.saveNote()})
            .store(in: &cancellables)
    }
    
    //MARK: Constraints
    func setConstraints(){
        textView.frame = CGRect(x: 0, y: 0, width: Int(view.bounds.width), height: Int(view.bounds.height))
        textView.backgroundColor = .systemBackground
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.font = UIFont.systemFont(ofSize: 18)
    }
    
    //MARK: Ações botões 
    @objc func actBack(){
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveNote(){
        if note == nil{
            try? CoreDataStack.shared.createNote(textInput: textView.text!, trip: trip!)
        }
        else{
            try? CoreDataStack.shared.editNote(note: note!, text: textView.text!)
        }
    }
}
