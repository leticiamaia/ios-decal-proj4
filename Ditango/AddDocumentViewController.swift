//
//  AddDocumentViewController.swift
//  Ditango
//
//  Created by Leticia Maia on 4/30/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit

class AddDocumentViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var languagePickerView: UIPickerView!
    
    @IBOutlet weak var inputTextView: UITextView!
    
    @IBOutlet weak var fileNameTextField: UITextField!
    
    let api = DitangoAPI()
    
    let pickerData = ["English(US)", "Portuguese(Brazil)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.languagePickerView.delegate = self
        self.languagePickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func saveDocumentAction(sender: AnyObject) {
        let documentName = fileNameTextField.text
        let text = inputTextView.text
        api.uploadText(text, documentName: documentName!, locale: "en_US")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
