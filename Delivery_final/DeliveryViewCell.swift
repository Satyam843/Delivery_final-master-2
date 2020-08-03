    //
    //  DeliveryViewCell.swift
    //  Delivery_final
    //
    //  Created by soc-admin on 7/30/20.
    //  Copyright © 2020 soc-admin. All rights reserved.
    //
    
    import UIKit
    //Protocol
    protocol  Delivery {
        func OnClick(index : Int)
    }
    class DeliveryViewCell: UITableViewCell,UITextFieldDelegate {
        //IB Outlets
        @IBOutlet weak var tapButtonMap: UIButton!
        @IBOutlet weak var cellTextName: UITextField!
        @IBOutlet weak var cellImageName: UIImageView!
        //variables
        var celldelegate : Delivery?
        var index : IndexPath?
        var onTextFieldEndEditing: ((String?) -> Void)?
        //View life cycle methods
        override func awakeFromNib() {
            super.awakeFromNib()
            cellTextName.borderStyle = .none
            cellTextName.delegate = self
        }
        //IB action methods
        @IBAction func tapPickLocation(_ sender: Any) {
            celldelegate?.OnClick(index: index!.row)
        }
        //Private methods
        func textFieldDidEndEditing(_ textField: UITextField) {
            //when editing is done.
            onTextFieldEndEditing?(textField.text)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            cellTextName
                .resignFirstResponder()
            return true
            
        }
    }
