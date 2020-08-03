//
//  DeliveryViewController.swift
//  Delivery_final
//
//  Created by soc-admin on 7/30/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//

import UIKit

class DeliveryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    //IB Outlets
    @IBOutlet weak var deliveryTableView: UITableView!
    @IBOutlet weak var saveData: UIButton!
    @IBOutlet weak var button: UIButton!
    //Variables
    var deliveryName = ["Client Name","Phone","Email","order Id","Address","Deliver Before","Description","Barcode"]
    var imageName = [UIImage(named: "name"),
                     UIImage(named: "call"),
                     UIImage(named: "gmailcropped"),
                     UIImage(named: "OrderId-1"),
                     UIImage(named: "address"),
                     UIImage(named: "Date"),
                     UIImage(named: "Description"),
                     UIImage(named: "BarCoad")
        
    ]
    var selectedCountry :  String?
    var cellData = [String]()
    var countryList = ["+91","92","93","+94","+95","+96","97"]
    //Constants
    let datePicker = UIDatePicker()
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        deliveryTableView.rowHeight = 75
        deliveryTableView.reloadData()
        donePressed()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @IBAction func tapPrintData(_ sender: Any) {
        var row = 0
        while (row != deliveryName.count) {
            let cell = deliveryTableView.cellForRow(at: IndexPath.init(row: row, section: 0)) as! DeliveryViewCell
            row   += 1
            print(cell.cellTextName.text!)
            
        }
    }
    //IB Action methods
    @IBAction func saveCellData(_ sender: UIButton) {
        // let rowIndexPath = sender.tag
        // let indexPath = IndexPath(row: rowIndexPath, section: 0)
        
    }
    @objc func keyBoardWillChange(notification : Notification)
    {
        print("Keyboard will show :\(notification.name.rawValue)")
        view.frame.origin.y = -175
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    //private Functions
    //Objectice c functions
    @objc func donePressed() {
        let cell = deliveryTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! DeliveryViewCell
        cell.cellTextName.text = "\(datePicker.date)"
        print(cell.cellTextName.text!)
        self.view.endEditing(true)
    }
    @objc func action()
    {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryName.count+1
    }
    
    ////Tableview methods(stubs)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
        if(indexPath.row == 8)
        {
            cell.cellTextName.placeholder = "Image"
            cell.tapButtonMap.isHidden = true
            cell.cellImageName.image = UIImage(named: "plusicon")
            return cell
        }
        else if(indexPath.row == 1)
        {
            let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            let pickerView = UIPickerView()
            pickerView.delegate = self
            //textFieldDelegate.leftView = pickerView
            cell.cellTextName.inputView = pickerView
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let button = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.action))
            toolbar.setItems([button], animated: true)
            toolbar.isUserInteractionEnabled = true
            cell.cellTextName.inputAccessoryView = toolbar
            cell.cellTextName.placeholder = deliveryName[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            cell.tapButtonMap.isHidden = true
            return cell
        }
        else if(indexPath.row == 4)
        {
            let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            
            
            cell.celldelegate=self
            cell.index=indexPath
            cell.cellTextName.placeholder = deliveryName[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            return cell
        }
        else if(indexPath.row == 5)
        {
            let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
            cell.cellTextName.inputAccessoryView = toolBar
            cell.cellTextName.inputView = datePicker
            //cell.cellTextField.text = "\(datePicker.date)"
            cell.cellTextName.placeholder = deliveryName[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            cell.tapButtonMap.isHidden = true
            toolBar.setItems([doneBtn], animated: true)
            return cell
        }
        else
        {
            cell.cellTextName.placeholder = deliveryName[indexPath.row]
            cell.cellImageName.image = imageName[indexPath.row]
            cell.tapButtonMap.isHidden = true
            return cell
        }
        
        
    }
    //Pickerview methods(stubs)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countryList[row]
        let cell = deliveryTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DeliveryViewCell
        cell.cellTextName.text = selectedCountry
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
