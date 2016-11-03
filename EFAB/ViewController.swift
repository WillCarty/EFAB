//
//  ViewController.swift
//  EFAB
//
//  Created by Robert White on 10/31/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class ViewController: UIViewController {
    
    func iLikeTheCodes() {
        for 1..<Int.max() {
            print("I am the bestsest coder ever")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let test = Test()
        
        print("starting call")
        WebServices.shared.getObject(test) { (object, error) in
            print("call returned")
            if let object = object {
                print(object.description())
            }else{
                print(error ?? Constants.JSON.unknownError)
            }
        }
        
        
        // get many posts
        let getPostsTest = Test()
        getPostsTest.requestType = .getPosts
        
        WebServices.shared.getObjects(getPostsTest) { (objects, error) in
            if let objects = objects {
                print("got \(objects.count) items")
            }else{
                print("get posts failed")
            }
        }
        
    }
}

/*        request(WebServices.AuthRouter.restRequest(test)).response { (d) in
 let request = d.request
 let response = d.response
 let data = d.data
 let error = d.error
 
 print("call returned")
 if error != nil {
 print("error: \(error)")
 }
 print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
 
 // Step 4: process response
 var testReturn: Test?
 var errorString: String?
 
 let statusCode = response?.statusCode
 if let statusCode = statusCode {
 switch statusCode {
 case 200:
 if let data = data {
 do {
 let json = try JSON(data: data)
 testReturn = try Test(json: json)
 } catch {}
 } else {
 errorString = Constants.JSON.unknownError
 }
 case 400:
 errorString = Constants.JSON.unknownError
 default:
 errorString = Constants.JSON.unknownError
 }
 }
 
 if let testReturn = testReturn {
 print(testReturn.description())
 } else {
 print(errorString ?? Constants.JSON.unknownError)
 }
 }
 
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 
 }
 */
