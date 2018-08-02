//
//  Country.swift
//  large-title-search
//
//  Created by Cmdev on 01/08/2018.
//  Copyright © 2018 PosCash. All rights reserved.
//

import UIKit
import EVReflection

class Country: EVObject {
    var name: String?
    var capital: String?
    var region: String?
    var subregion: String?
    var flag: String?
    var population: NSNumber?
    var area: NSNumber?
    var callingCodes = [String]()
    var languages = [Language]()
    var currencies = [Currency]()
}
