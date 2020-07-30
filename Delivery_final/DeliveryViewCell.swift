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
class DeliveryViewCell: UITableViewCell {
    //IB Outlets
    @IBOutlet weak var cellTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var cellImageView: UIImageView!
    //variables
    var celldelegate : Delivery?
    var index : IndexPath?
    var onTextFieldEndEditing: ((String?) -> Void)?
  
   
    //View life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTextField.borderStyle = .none
        
        // Initialization code
    }
    //IB action methods
    @IBAction func pickLocation(_ sender: Any) {
        celldelegate?.OnClick(index: index!.row)
    }
    //Private methods
    func textFieldDidEndEditing(_ textField: UITextField) {
        //when editing is done.
        onTextFieldEndEditing?(textField.text)
    }
    


}
