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
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7ImlkIjozODEsIm5hbWUiOiJUZXN0ZSBEaXRhbkdvIiwiZW1haWwiOiJ0ZXN0QGRpdGFuZ28uY29tLmJyIiwibG9jYWxlIjoiZW5fVVMiLCJyb2xlcyI6W119LCJrZXkiOiJEaXRhbmdvX0FwcF9LZXkifQ.lDbhoOodT02r0_v1xXNL9hJQMymIkIEVJlMJJHW4_YU"
    
    func getDocuments(completion: (([Document]) -> Void)!) {
        let searchURL = "/document/search"
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
        var documentsArray = [Document]()
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            do {
                let documentsInfoArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
                for dict: NSDictionary in documentsInfoArray {
                    let id = (dict.valueForKey("id") as! NSNumber).longLongValue
                    let filename = dict.valueForKey("fileName") as! String
                    let audiosArray = dict.valueForKey("audioDocs") as! NSArray
                    var audio: Audio?
                    if(audiosArray.count > 0) {
                        let audioID = (audiosArray[0].valueForKey("id") as! NSNumber).longLongValue
                        let audioFilename = audiosArray[0].valueForKey("fileName") as! String
                        audio = Audio(id: audioID, filename: audioFilename)
                    }
                    let document = Document(id: id, filename: filename, audio:audio)
                    documentsArray.append(document)
                }
               completion(documentsArray)
                
            } catch {}
        }
        task.resume()
    }
    
    func convertDocument(documentId: Int64, documentName: String, completion: (() -> Void)!) {
        let searchURL = "/document/convert";
        let request = NSMutableURLRequest(URL: NSURL(string: ditangoURL+searchURL)!)
        request.HTTPMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json:[String: AnyObject] = [
            "documentId" : NSNumber(longLong: documentId),
            "audioName" : documentName,
            "audioFileName" :documentName + ".mp3",
            "voice" : 0,
            "startPage" : NSNull(),
            "endPage" : NSNull(),
            "marginLeft" : NSNull(),
            "marginTop" : NSNull(),
            "marginRight" : NSNull(),
            "marginBottom" : NSNull(),
            "text" : NSNull()]
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
            
            print(response)
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString)
            completion()
        }
        task.resume()

    }
    
    func uploadText(fileText : String, documentName : String, locale : String, completion: (() -> Void)!) {
        let searchURL = "/document/uploadtext";
        let request = NSMutableURLRequest(URL: NSURL(string: ditangoURL+searchURL)!)
        request.HTTPMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json:[String: AnyObject] = [
            "fileText" : fileText,
            "documentName" : documentName,
            "documentFileName" : documentName + ".txt",
            "locale" : locale]
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
            
            do {
                let documentInfo = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let documentId = (documentInfo.valueForKey("id") as! NSNumber).longLongValue
                self.convertDocument(documentId, documentName: documentName, completion:completion)
                
            } catch {}

            
            print(response)
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString)
        }
        task.resume()
    }
    
    func getAudioUrl(audioId: String, completion: ((String) -> Void)!) {
        let searchURL = "/audio/url/" + audioId;
        let request = NSMutableURLRequest(URL: NSURL(string: ditangoURL+searchURL)!)
        request.HTTPMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "authorization")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            completion(String(responseString))
        }
        task.resume()
    }
    
    func deleteDocument(documentId: String) {
        let searchURL = "/document/" + documentId
        let request = NSMutableURLRequest(URL: NSURL(string: ditangoURL+searchURL)!)
        request.HTTPMethod = "DELETE"
        request.setValue(token, forHTTPHeaderField: "authorization")

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
        }
        task.resume()
    }

}