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
    var data : DeliveryData?
    {
        didSet
        {
            updateCell()
        }
    }
    //View life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTextName.borderStyle = .none
        cellTextName.delegate = self
    }
    func updateCell()
    {
        if let data = data
        {
            cellTextName.text  = data.value
            cellTextName.placeholder = data.placeholder
        }
    }
    //IB action methods
    @IBAction func tapPickLocation(_ sender: Any) {
        celldelegate?.OnClick(index: index!.row)
    }
    //Private methods
    func textFieldDidEndEditing(_ textField: UITextField) {
        data?.value = cellTextName.text ?? "no value"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cellTextName
            .resignFirstResponder()
        return true
        
    }
}
