//
//  DeliveryData.swift
//  Delivery_final
//
//  Created by soc-admin on 8/4/20.
//  Copyright © 2020 soc-admin. All rights reserved.
//
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
