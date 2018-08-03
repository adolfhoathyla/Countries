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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustFlagHeight()
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
