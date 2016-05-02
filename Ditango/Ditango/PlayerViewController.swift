//
//  PlayerViewController.swift
//  Ditango
//
//  Created by Leticia Maia on 4/30/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var playPauseButton: UIButton!
    
    
    var audio : Audio?
    
    let api = DitangoAPI()
    
    
    var player: AVPlayer!
    
    var item: AVPlayerItem?
    
    @IBAction func playPauseAction(sender: AnyObject) {
        if(playPauseButton.selected == false) {
            playPauseButton.selected = true
            player.play()
        } else {
            playPauseButton.selected = false
            player.pause()
        }
        
    }
    
    override func viewDidLoad() {
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        let contextImage = UIImage(named: "bg2.jpg")
        
        let size = contextImage?.size
        let rect = CGRectMake((size?.width)!/2.5, 0 , (size?.width)!, (size?.height)!)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage!.CGImage, rect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: contextImage!.scale, orientation: contextImage!.imageOrientation)
        backgroundImage.image = image
        
        self.view.insertSubview(backgroundImage, atIndex: 0)
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        let playImage = UIImage(named: "play")?.imageWithRenderingMode(.AlwaysTemplate)
        let pauseImage = UIImage(named: "pause")?.imageWithRenderingMode(.AlwaysTemplate)
        playPauseButton.setImage(playImage, forState: UIControlState.Normal)
        playPauseButton.setImage(pauseImage, forState: UIControlState.Selected)
        super.viewDidLoad()
        player = AVPlayer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        api.getAudioUrl(String(audio!.id), completion: setAudioUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    func setAudioUrl(url: String!) {
        item = AVPlayerItem(URL: NSURL(string: url)!)
        player.replaceCurrentItemWithPlayerItem(item)
        playPauseButton.selected = false
        //player.play()
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
