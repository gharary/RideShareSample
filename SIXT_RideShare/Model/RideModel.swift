//
//  RideModel.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/16/21.
//

import Foundation

/// RideModel base on the JSON retreived from server
struct RideModel:Codable {
    
    let id:String
    let modelID:String
    let modelName:String
    let name:String
    let make:String
    let group:String
    let color:String
    let series:String
    let fuelType:String
    let fuelLvl:Float
    let transmission:String
    let license:String
    let lat:Double
    let long:Double
    let cleanliness:String
    let image:String
    
    
    enum CodingKeys:String,CodingKey {
        case id
        case modelID = "modelIdentifier"
        case modelName
        case name
        case make
        case group
        case color
        case series
        case fuelType
        case fuelLvl = "fuelLevel"
        case transmission 
        case license = "licensePlate"
        case lat = "latitude"
        case long = "longitude"
        case cleanliness = "innerCleanliness"
        case image = "carImageUrl"
    }
    
}

/*
         "id": "WMWSW31030T222518",
         "modelIdentifier": "mini",
         "modelName": "MINI",
         "name": "Vanessa",
         "make": "BMW",
         "group": "MINI",
         "color": "midnight_black",
         "series": "MINI",
         "fuelType": "D",
         "fuelLevel": 0.7,
         "transmission": "M",
         "licensePlate": "M-VO0259",
         "latitude": 48.134557,
         "longitude": 11.576921,
         "innerCleanliness": "REGULAR",
         "carImageUrl": "https://cdn.sixt.io/codingtask/images/mini.png"
 */
