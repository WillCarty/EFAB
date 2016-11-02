//
//  BudgetListViewController.swift
//  EFAB
//
//  Created by Robert White on 11/1/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import MBProgressHUD

class BudgetListViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeControl: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired() {
            
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        UserStore.shared.logout {
        self.performSegue(withIdentifier:"PresentLogin", sender: self)
      }
    }
    
    @IBAction func backTapped(_ sender: Any) {
    }
   
    @IBAction func forwardTapped(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
