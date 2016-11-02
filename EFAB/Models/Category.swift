//
//  User.swift
//  EFAB
//
//  Created by TEKYAdmin on 11/2/16.
//  Copyright © 2016 EFA. All rights reserved.
//
//
//  Test.swift
//  EFAB
//
//  Created by Terrence Kunstek on 10/31/16.
//  Copyright © 2016 EFA. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

// Just a test object to excercise the network stack
class Category : NetworkModel {
    /*
     "username": "string",
     "password": "string",
     "email": "string"
     "token": "string",
     "expiration": "2016-11-01T20:58:52.318Z"
     */
    
    var id : Int?
    var name : String?
    var amount : Double?
    
    var startDate: String?
    var endDate : String?
  
    
    // Request Type
    enum RequestType {
        case create
        case week
        case month
    }
    var requestType = RequestType.week
    
    var searchDate : Date?
    
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        id = try? json.getInt(at: Constants.Category.id)
        name = try? json.getString(at: Constants.Category.name)
        amount = try? json.getDouble(at: Constants.Category.amount)
    }
    
    init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
        requestType = .create
    }
    
  
    init(month: Date){
        requestType = .month
        searchDate = month
    }
    
    init(week: Date) {
        requestType = .week
        searchDate = week
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .create:
            return .post
        default:
            return .get
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .create:
            return "/api/category/createCategory"
        case .week:
            return "/api/category/getCategory/year/\(searchDate!.year())/month/\(searchDate!.month())/day/\(searchDate!.day())"
        case .month:
            return "/api/category/getCategory/year/\(searchDate!.year())/month/\(searchDate!.month())"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
       switch requestType {
       case .create:
          let startDate = Utils.adjustedTime().toString(.iso8601(nil))
        
          var params: [String: AnyObject] = [:]
          params[Constants.Category.name] = name as AnyObject?
          params[Constants.Category.amount] = amount as AnyObject?
          params[Constants.Category.startDate] = startDate as AnyObject?
        
        return params
    default:
        return nil
     
        }
        
    
    }
    
}
