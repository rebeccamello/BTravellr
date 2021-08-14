//
//  TextFieldTableViewCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 13/07/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    static var identifier = "textField"
    
    let dataTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = UIFont.systemFont(ofSize: 20)
            return textField
        }()

    func initConstraints(){
        contentView.addSubview(dataTextField)

        NSLayoutConstraint.activate([
            dataTextField.heightAnchor.constraint(equalToConstant: 40),
            dataTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dataTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dataTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dataTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
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
