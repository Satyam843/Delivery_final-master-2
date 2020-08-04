//
//  DeliveryViewController.swift
//  Delivery_final
//
//  Created by soc-admin on 7/30/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit
class DeliveryData {
    let placeholder: String
    var value: String = ""
    
    init(_ placeholder: String) {
        self.placeholder = placeholder
    }
}
var deliveryData: [DeliveryData] = [
    DeliveryData("Name"),
    DeliveryData("Phone"),
    DeliveryData("Email"),
    DeliveryData("order"),
    DeliveryData("Address"),
    DeliveryData("Deliver before"),
    DeliveryData("Description"),
    DeliveryData("Barcode"),
    DeliveryData("Image")
]

class DeliveryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    //IB Outlets
    @IBOutlet weak var deliveryTableView: UITableView!
    @IBOutlet weak var saveData: UIButton!
    //Variables
    var imageName = [UIImage(named: "name"),
                     UIImage(named: "call"),
                     UIImage(named: "gmailcropped"),
                     UIImage(named: "OrderId-1"),
                     UIImage(named: "address"),
                     UIImage(named: "Date"),
                     UIImage(named: "Description"),
                     UIImage(named: "BarCoad")
        
    ]
    var selectedCode :  String?
    var keyBoardType = [UIKeyboardType.default,UIKeyboardType.numberPad,UIKeyboardType.emailAddress,UIKeyboardType.default,UIKeyboardType.default,UIKeyboardType.default,UIKeyboardType.default,UIKeyboardType.default]
    //Constants
    let datePicker = UIDatePicker()
    
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        deliveryTableView.rowHeight = 75
        deliveryTableView.reloadData()
        donePressed()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(DeliveryViewController.donePressed), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    //IB Action methods
    @IBAction func tapPrintData(_ sender: Any) {
        for data in deliveryData
        {
            print(data.value)
        }
    }
    //private Functions
    //Objectice c functions
    @objc func donePressed() {
        let cell = deliveryTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! DeliveryViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY HH: MM a "
        cell.cellTextName.clearsOnBeginEditing = true
        if(cell.cellTextName.isEditing)
        {
            cell.cellTextName.text = dateFormatter.string(from: datePicker.date)
        }
        //cell.data?.value = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cell = deliveryTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! DeliveryViewCell
        guard !string.isEmpty else {
            return true
        }
        cell.cellTextName.keyboardType = .phonePad
        if cell.cellTextName.keyboardType == .numberPad {
            if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {
                
                return false
            }
        }
        
        
        
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return deliveryName.count+1
        return deliveryData.count
    }
    ////Tableview methods(stubs)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
        if(indexPath.row == 8)
        {
            // cell.cellTextName.placeholder = "Image"
            cell.data = deliveryData[indexPath.row]
            cell.tapButtonMap.isHidden = true
            cell.cellImageName.image = UIImage(named: "plusicon")
            return cell
        }
            
        else if(indexPath.row == 4)
        {
            let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            cell.celldelegate=self
            cell.index=indexPath
            cell.data = deliveryData[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            return cell
        }
        else if(indexPath.row == 5)
        {
            let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            cell.cellTextName.inputView = datePicker
            cell.data = deliveryData[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            cell.tapButtonMap.isHidden = true
            return cell
        }
        else
        {
            cell.data = deliveryData[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            cell.tapButtonMap.isHidden = true
            cell.cellTextName.keyboardType = keyBoardType[indexPath.row]
            return cell
        }
    }
    //Pickerview methods(stubs)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

extension  DeliveryViewController : Delivery
{
    
    func OnClick(index: Int) {
        let alert = UIAlertController(title: "hello", message: "Click here to select address", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: .none))
        present(alert, animated: true, completion: .none)
    }
    
}
