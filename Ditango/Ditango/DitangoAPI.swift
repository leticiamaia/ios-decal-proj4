//
//  DitangoAPI.swift
//  Ditango
//
//  Created by Leticia Maia on 4/29/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import Foundation

class DitangoAPI {
    let ditangoURL = "http://web.ditango.com.br/service"
    let searchURL = "/document/search"
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7ImlkIjozODEsIm5hbWUiOiJUZXN0ZSBEaXRhbkdvIiwiZW1haWwiOiJ0ZXN0QGRpdGFuZ28uY29tLmJyIiwibG9jYWxlIjoiZW5fVVMiLCJyb2xlcyI6W119LCJrZXkiOiJEaXRhbmdvX0FwcF9LZXkifQ.lDbhoOodT02r0_v1xXNL9hJQMymIkIEVJlMJJHW4_YU"
    
    func getDocuments(){
        //Test 5.2 first
        let request = NSMutableURLRequest(URL: NSURL(string: ditangoURL+searchURL)!)
        request.HTTPMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json:[String: AnyObject] = [
        "searchExpression" : NSNull(),
        "size" : 10,
        "start": 0]
        var jsonData = NSData()
        do {
        jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0))
        } catch {
            print("---> ERROR")
        }
        request.HTTPBody = jsonData
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString)
        }
        task.resume()
    }
}