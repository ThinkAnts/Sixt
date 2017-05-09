//
//  ApiRequest.swift
//  SixtCars
//
//  Created by Ravi on 09/05/17.
//  Copyright © 2017 ThinkAnts. All rights reserved.
//

import Foundation
import ObjectMapper


public func dataTask(request: NSURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
    
    // set up the session
    let session = URLSession.shared

    // make the request
    let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
        guard error == nil else {
            print("")
            return
        }
        
        if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
               completion(true,json as AnyObject)
            } else {
               completion(false,json as AnyObject)
            }
        }
    })
    task.resume()
}
