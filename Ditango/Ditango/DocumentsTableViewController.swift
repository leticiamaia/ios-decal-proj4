//
//  DocumentsTableViewController.swift
//  Ditango
//
//  Created by Leticia Maia on 4/29/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit

class DocumentsTableViewController: UITableViewController {
    
    var documents = [Document]()
    let api = DitangoAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        let contextImage = UIImage(named: "bg2.jpg")
        
        let size = contextImage?.size
        let rect = CGRectMake((size?.width)!/2.5, 0 , (size?.width)!, (size?.height)!)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage!.CGImage, rect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: contextImage!.scale, orientation: contextImage!.imageOrientation)
        backgroundImage.image = image
        
        self.view.insertSubview(backgroundImage, atIndex: 0)
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       // api.getAudioUrl("831")
        api.getDocuments(setDocuments)
        //api.uploadText("my test file. UC, Berkeley is the best UC", documentName: "Berkeley", locale: "en_US")
        print(documents)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return documents.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DocumentCellIdentifier", forIndexPath: indexPath) as! DocumentsTableViewCell

        cell.documentNameLabel.text = documents[indexPath.row].filename

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("audiosToPlayerSegue", sender: indexPath.row)})
        
    }
    
    func setDocuments(newDocuments: [Document]) {
        dispatch_async(dispatch_get_main_queue()) {
            print(newDocuments)
            self.documents = newDocuments
            self.tableView.reloadData()
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let id = String(documents[indexPath.row].id)
            documents.removeAtIndex(indexPath.row)
            api.deleteDocument(id)
            self.tableView.reloadData()
           // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } /*else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        } */
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "audiosToNewDocument") {
            let navigationVC = segue.destinationViewController as! UINavigationController
            let destinationVC = navigationVC.topViewController as! AddDocumentViewController
            destinationVC.sender = self
        }
        
        if(segue.identifier == "audiosToPlayerSegue") {
            let documentIndex = sender as! Int
            let destinationVC = segue.destinationViewController as! PlayerViewController
            destinationVC.documents = documents
            destinationVC.currentTrackNumber = documentIndex
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
