//
//  NetWork.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class APIClient: NSObject {
    
    func getMethod(_ api : API) -> Alamofire.HTTPMethod {
            let requestMethod : Alamofire.HTTPMethod
            switch api.method {
            case "POST":
                requestMethod = .post
                break
            case "PUT":
                requestMethod = .put
                break
            case "DELETE":
                requestMethod = .delete
            default:
                requestMethod = .get
                break
            }
            return requestMethod
        }
}
