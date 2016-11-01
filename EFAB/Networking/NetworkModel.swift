//
//  NetworkModel.swift
//  EFAB
//
//  Created by Robert White on 10/31/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

// Describes what you need to make a network request and read it
protocol NetworkModel: JSONDecodable {
    // creat the object by reading JSON
    init(json: JSON) throws
    // create an empty object
    init()
    
    // what is the HTTP Method (Get/Post/Put/etc)
    func method() -> Alamofire.HTTPMethod
    // REST URL to the resource i.i. http://server.com/post/1
    func path() -> String
    // Convert the object to a dictionary for later conversion to JSON
    func toDictionary() -> [String: AnyObject]?
}
