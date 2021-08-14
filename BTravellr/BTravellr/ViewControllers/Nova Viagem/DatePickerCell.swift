//
//  DatePickerCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 12/08/21.
//

import UIKit

class DatePickerCell: UITableViewCell {
    static let identifier = "DatePickerCell"
    
    let picker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
            return picker
        }()

    func initConstraints(){
        contentView.addSubview(picker)
        NSLayoutConstraint.activate([
//            picker.heightAnchor.constraint(equalToConstant: 40),
//            picker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            picker.widthAnchor.constraint(equalToConstant: 300),
            picker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            picker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            picker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
