//
//  TextFieldTableViewCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 13/07/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    let dataTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = UIFont.systemFont(ofSize: 20)
            return textField
        }()
    
    func initConstraints(){
        addSubview(dataTextField)
            
        NSLayoutConstraint.activate([
            dataTextField.heightAnchor.constraint(equalToConstant: 40),
            dataTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dataTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dataTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dataTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    enum TextFieldData: Int {
        case name = 0
        case destine = 1
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    @objc func valueChanged(_ textField: UITextField){
//        switch textField.tag {
//        case TextFieldData.name.rawValue:
//            user.name = textField.text
//        case TextFieldData.destine.rawValue:
//            user.surname = textField.text
//        default:
//            break
//        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }
        
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var placeholder: String? {
    didSet {
        guard let item = placeholder else {return}
        dataTextField.placeholder = item
        }
    }

}
