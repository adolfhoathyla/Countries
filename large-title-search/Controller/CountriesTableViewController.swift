//
//  CountriesTableViewController.swift
//  large-title-search
//
//  Created by Cmdev on 01/08/2018.
//  Copyright © 2018 PosCash. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {

    var countries = [Country]()
    var filteredCountries = [Country]()
    
    var search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        CountriesAPIHelper.loadAllCountries { (countries, success) in
            guard let countries = countries else { return }
            self.countries = countries
            self.tableView.reloadData()
        }
        
        addSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Search bar
    fileprivate func addSearchBar() {
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search countries..."
        search.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        self.navigationItem.searchController = search
    }
    
    fileprivate func searchBarIsEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    
    fileprivate func filterContentForSearchText(searchText: String) {
        filteredCountries = countries.filter({ (country) -> Bool in
            return country.name!.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
    fileprivate func isFiltering() -> Bool {
        return search.isActive && !searchBarIsEmpty()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredCountries.count : countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "COUNTRY_CELL_IDENTIFIER", for: indexPath) as? CountryTableViewCell

        let country = isFiltering() ? filteredCountries[indexPath.row] : countries[indexPath.row]
        
        cell?.name.text = country.name ?? "<country name>"
        cell?.region.text = (country.region ?? "<region name>") + ", " + (country.subregion ?? "<subregion name>")

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GO_TO_COUNTRY_DETAIL", sender: indexPath)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "GO_TO_COUNTRY_DETAIL":
            guard let indexPath = sender as? IndexPath else { return }
            let countryVC = segue.destination as? CountryDetailViewController
            countryVC?.country = isFiltering() ? filteredCountries[indexPath.row] : countries[indexPath.row]
        default:
            break
        }
    }
    

}





//MARK: - search rsults updating
extension CountriesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
