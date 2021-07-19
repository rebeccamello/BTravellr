//
//  TextFieldTableViewCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 13/07/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
//    let textos = ["Nome", "Destino", "Ida", "Volta"]
//
//    class TextField: UITextField{
//        override func textRect(forBounds bounds: CGRect) -> CGRect {
//            return bounds.insetBy(dx: 24, dy: 0)
//        }
//
//        override func editingRect(forBounds bounds: CGRect) -> CGRect {
//            return bounds.insetBy(dx: 24, dy: 0)
//        }
//        override var intrinsicContentSize: CGSize{
//            return .init(width: 0, height: 44)
//        }
//    }
//
//    let textField: UITextField = {
//        let tf = TextField()
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.placeholder = textos[indexPath.row]
//        return tf
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(textField)
//        textField.frame = bounds
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
