//
//  TextFieldTableViewCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 13/07/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    class TextField: UITextField {
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override var intrinsicContentSize: CGSize{
            return .init(width: 0, height: 44)
        }
    }
    
    let textField: UITextField = {
        let tf = TextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nome"
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
        textField.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
