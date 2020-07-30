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
    //Variables
    @IBOutlet weak var saveData: UIButton!
    
    @IBOutlet weak var button: UIButton!
    var deliveryData = ["Client Name","Phone","Email","order Id","Address","Deliver Before","Description","Barcode"]
    var imageData = [UIImage(named: "name"),
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
    // var imageData = ["name","call","gmail","OrderId","address","Date","Description","Barcoad"]
    //Constants
     let datePicker = UIDatePicker()
   
   //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
 deliveryTableView.rowHeight = 75
        deliveryTableView.reloadData()
        donePressed()
        // Do any additional setup after loading the view.
    }
    //IB Action methods
    @IBAction func saveCellData(_ sender: UIButton) {
        let rowIndexPath = sender.tag
        let indexPath = IndexPath(row: rowIndexPath, section: 0)
        let cell = deliveryTableView.cellForRow(at: IndexPath.init(row: rowIndexPath, section: 0)) as! DeliveryViewCell
        cellData.append(cell.cellTextField.text!)
        print(cellData[0])
    }
    //private Functions
    //Objectice c functions
    @objc func donePressed() {
        let cell = deliveryTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! DeliveryViewCell
        cell.cellTextField.text = "\(datePicker.date)"
        print(cell.cellTextField.text!)
        self.view.endEditing(true)
        
    }
    @objc func action()
    {
        view.endEditing(true)
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryData.count+1
    }
   
    ////Tableview methods(stubs)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
        if(indexPath.row == 8)
        {
            cell.cellTextField.placeholder = "Image"
    cell.button.isHidden = true
            cell.cellImageView.image = UIImage(named: "plusicon")
return cell        }
            else if(indexPath.row == 1)
        {
             let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            let pickerView = UIPickerView()
            pickerView.delegate = self
            //textFieldDelegate.leftView = pickerView
          cell.cellTextField.inputView = pickerView
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let button = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.action))
            toolbar.setItems([button], animated: true)
            toolbar.isUserInteractionEnabled = true
           cell.cellTextField.inputAccessoryView = toolbar
            cell.cellTextField.placeholder = deliveryData[1]
            cell.cellImageView.image = imageData[1]
              cell.button.isHidden = true
            return cell
        }
            else if(indexPath.row == 4)
        {
           let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
           
         
            cell.celldelegate=self
            cell.index=indexPath
            cell.cellTextField.placeholder = deliveryData[4]
            cell.cellImageView.image = imageData[4]
            return cell
        }
            else if(indexPath.row == 5)
        {
             let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryViewCell
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
            cell.cellTextField.inputAccessoryView = toolBar
            cell.cellTextField.inputView = datePicker
            //cell.cellTextField.text = "\(datePicker.date)"
            cell.cellTextField.placeholder = deliveryData[5]
            cell.cellImageView.image = imageData[5]
              cell.button.isHidden = true
            toolBar.setItems([doneBtn], animated: true)
           return cell
        }
        else
        {
            cell.cellTextField.placeholder = deliveryData[indexPath.row]
            cell.cellImageView.image = imageData[indexPath.row]
              cell.button.isHidden = true
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
        cell.cellTextField.text = selectedCountry
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension  DeliveryViewController : Delivery
{
    
    func OnClick(index: Int) {
        let alert = UIAlertController(title: "hello", message: "Click here to edit", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: .none))
        present(alert, animated: true, completion: .none)
    }
    
}
