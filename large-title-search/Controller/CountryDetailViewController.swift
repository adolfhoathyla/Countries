//
//  CountryDetailViewController.swift
//  large-title-search
//
//  Created by Cmdev on 03/08/2018.
//  Copyright © 2018 PosCash. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var flagHeightConstraint: NSLayoutConstraint!
    
    var country = Country()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustFlagHeight()
        
        self.title = country.name
        
        CountriesAPIHelper.downloadFlag(country: country) { (flag, success) in
            if success {
                self.flag.image = flag
                self.indicator.stopAnimating()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Flag image view
    fileprivate func adjustFlagHeight() {
        flagHeightConstraint.constant = view.frame.width / 1.7
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




extension CountryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "capital"
        case 1:
            return "region"
        case 2:
            return "population"
        case 3:
            return "area"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GENERIC_INFO_IDENTIFIER", for: indexPath) as? CountryGenericInfoTableViewCell
        
        switch indexPath.section {
        case 0:
            cell?.info.text = country.capital
        case 1:
            cell?.info.text = (((country.region ?? "") + ", " + (country.subregion ?? "") == ", ") ? "<no info>" : country.region! + ", " + country.subregion!)
        case 2:
            cell?.info.text = "\(country.population?.intValue ?? 0) hab."
        case 3:
            cell?.info.text = "\(country.area?.intValue ?? 0) km²"
        default:
            break
        }
        
        return cell!
    }
}
