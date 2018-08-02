//
//  CountriesAPIHelper.swift
//  large-title-search
//
//  Created by Cmdev on 02/08/2018.
//  Copyright © 2018 PosCash. All rights reserved.
//

import UIKit
import EVReflection
import Alamofire
import AlamofireJsonToObjects

class CountriesAPIHelper: NSObject {
    static let uri = "https://restcountries.eu/rest/v2"
    static var alamofireManager: Alamofire.SessionManager?
    
    //MARK: - Config Alamofire
    static func configAlamofire() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 50
        configuration.allowsCellularAccess = true
        CountriesAPIHelper.alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //MARK: - Countries
    static func loadAllCountries(completionHandler: @escaping ((_ countries: [Country]?, _ success: Bool) -> ())) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        CountriesAPIHelper.configAlamofire()
        let resource = uri + "/all"
        CountriesAPIHelper.alamofireManager?.request(resource, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseArray(completionHandler: { (response: DataResponse<[Country]>) in
            guard let countriesResponse = response.response else { return }
            switch countriesResponse.statusCode {
            case 200:
                if let countries = response.result.value {
                    completionHandler(countries, true)
                }
            default:
                completionHandler(nil, false)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
}
