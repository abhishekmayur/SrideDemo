//
//  API.swift
//  NewFeed
//
//  Created by Abhishek Dhamdhere on 12/07/21.
//

import Foundation
import UIKit
import Alamofire
import ReachabilitySwift
import SwiftyJSON
import AlamofireSwiftyJSON
import ReachabilitySwift
class APIEngine: NSObject {
    let API_VERSION = "1"
    //MARK: Singlton class
    static let sharedInstance = APIEngine()
    //MARK: API Method
    func getLAPI(url: String,  param : [String : AnyObject], completionHandler:@escaping (DataResponse<JSON>?, Error?) -> ()) {
       
        
        print("URL GET:\(url)")
        print("PARAM :\(param)")
        
        
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.queryString,headers:nil)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                //Helper.sharedInstance.hideLoader()
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                print("Valdiate")
                print(request)
                print(data)
             //   Helper.sharedInstance.hideLoader()
                return .success
            }
            .responseSwiftyJSON { response in
                debugPrint(response)
                
                //                 if (self.failureCheck(response: response))
                //                 {
                print("In failure")
                print(response)
                completionHandler(response, nil)
                print(response)
                // }
                
            }
    }
    // MARK: GET API
    
    func newsFeedAPI(param:[String:AnyObject], completionHandler:@escaping (DataResponse<JSON>?, Error?) -> ()) {
        
        let strURL = BaseURL + newsFeedURL
        
        self.getLAPI(url: strURL, param:param, completionHandler: { response, error in
            
            completionHandler(response, error)
            
            
        })
    }
    
    
}
