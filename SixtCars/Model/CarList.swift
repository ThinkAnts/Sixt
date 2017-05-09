//
//  CarList.swift
//  SixtCars
//
//  Created by Ravi on 09/05/17.
//  Copyright © 2017 ThinkAnts. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct AllCarsList: Mappable {
    var mainList = [CarsList]()
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        mainList <- map[""]
    }
}

struct CarsList: Mappable {
    var id = ""
    var modelIdentifier = ""
    var modelName = ""
    var name = ""
    var make = ""
    var group = ""
    var color = ""
    var series = ""
    var fuelType = ""
    var fuelLevel = 0
    var transmission = ""
    var licensePlate = ""
    var latitude = 0.0
    var longitude = 0.0
    var innerCleanliness = ""
    var carImageUrl = ""
    
    init?(map: Map) {
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        modelIdentifier <- map["modelIdentifier"]
        modelName <- map["modelName"]
        name <- map["name"]
        make <- map["make"]
        group <- map["group"]
        color <- map["color"]
        series <- map["series"]
        fuelType <- map["fuelType"]
        fuelLevel <- map["fuelLevel"]
        transmission <- map["transmission"]
        licensePlate <- map["licensePlate"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        innerCleanliness <- map["innerCleanliness"]
        carImageUrl <- map["carImageUrl"]
    }
}
