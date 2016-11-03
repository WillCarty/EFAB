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
    
    let refreshControl = UIRefreshControl()
    var currentDate = Utils.adjustedTime()
    
    let weekIndex = 0
    let monthIndex = 1
    
    var weekCategories: [Date: [Category]] = [:]
    var monthCategories: [Date: [Category]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view.
        
        refreshControl.addTarget(self, action: #selector(BudgetListViewController.loadCategories), for:
            .valueChanged)
        tableView.addSubview(refreshControl)
    
        dateLabel.text = getDateRange()
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
        switch timeControl.selectedSegmentIndex {
        case weekIndex:
            currentDate = currentDate.dateBySubtractingDays(7)
        default:
            let day = currentDate.day()
            currentDate = currentDate.dateAtTheStartOfMonth().dateBySubtractingDays(1)
            currentDate = currentDate.dateAtTheStartOfMonth().dateByAddingDays(min(day - 1, currentDate.monthDays() - 1))
        }
        setupDateHeader()
    }
   
    @IBAction func forwardTapped(_ sender: Any) {
        switch timeControl.selectedSegmentIndex {
        case weekIndex:
            currentDate = currentDate.dateByAddingDays(7)
        default:
            let day = currentDate.day()
            currentDate = currentDate.dateAtTheStartOfMonth().dateByAddingDays(currentDate.monthDays())
            currentDate = currentDate.dateByAddingDays(min(day - 1, currentDate.monthDays() - 1))
        }
        setupDateHeader()
    }
   
    @IBAction func timePeriodChanged(_ sender: Any) {
        setupDateHeader()
        print("period changed")
    }
    
    func loadCategories() {
        self.refreshControl.endRefreshing()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    fileprivate func getDateRange() -> String {
        let timePeriod = timeControl.selectedSegmentIndex
        switch timePeriod {
        case weekIndex:
            let startDate = currentDate.dateAtStartOfWeek()
            let endDate = currentDate.dateAtEndOfWeek()
            let startMonth = startDate.toString(.custom("MMM"))
            let endMonth = endDate.toString(.custom("MMM"))
            if startDate.year() == endDate.year() {
                if startDate.month() == endDate.month() {
                    return "\(startMonth) \(startDate.day()) - \(endDate.day()), \(startDate.year())"
                } else {
                    return "\(startMonth) \(startDate.day()) - \(endMonth) \(endDate.day()), \(startDate.year())"
                }
            } else {
                return "\(startMonth) \(startDate.day()), \(startDate.year()) - \(endMonth) \(endDate.day()), \(endDate.year())"
            }
        default:
            return "\(currentDate.toString(.custom("MMM"))) \(currentDate.year())"
        }
    }
    
    fileprivate func setupDateHeader() {
        switch timeControl.selectedSegmentIndex {
        case weekIndex:
            if currentDate.isSameWeekAsDate(Date()) {
                currentDate = Utils.adjustedTime()
            }
            
            if !getCurrentWeek().isEmpty {
                tableView.reloadData()
            }
        default:
            if currentDate.month() == Date().month() && currentDate.year() == Date().year() {
                currentDate = Utils.adjustedTime()
            }
            
            if !getCurrentMonth().isEmpty {
                tableView.reloadData()
            }
        }
        dateLabel.text = getDateRange()
        loadCategories()
    }
    
    fileprivate func getCurrentWeek() -> [Category] {
        return weekCategories[currentDate.dateAtStartOfWeek().dateAtStartOfDay()] ?? []
    }
    
    fileprivate func getCurrentMonth() -> [Category] {
        return monthCategories[currentDate.dateAtTheStartOfMonth().dateAtStartOfDay()] ?? []
    }
    
    

}// class brace


extension BudgetListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
        return 0
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
