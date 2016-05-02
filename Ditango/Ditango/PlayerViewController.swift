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
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var audioNameLabel: UILabel!
    var documents :[Document]?
    var currentTrackNumber: Int = 0
    
    let api = DitangoAPI()
    
    @IBOutlet weak var progressBar: UIProgressView!
    
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
        
        progressBar.setProgress(0, animated: false)
        
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
        let nextImage = UIImage(named: "next")?.imageWithRenderingMode(.AlwaysTemplate)
        let previousImage = UIImage(named: "previous")?.imageWithRenderingMode(.AlwaysTemplate)
        playPauseButton.setImage(playImage, forState: UIControlState.Normal)
        playPauseButton.setImage(pauseImage, forState: UIControlState.Selected)
        nextButton.setImage(nextImage, forState: UIControlState.Normal)
        previousButton.setImage(previousImage, forState: UIControlState.Normal)
        super.viewDidLoad()
        player = AVPlayer()
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func update() {
        if let i = item {
            let time = CMTimeGetSeconds(i.currentTime())
            let siz = CMTimeGetSeconds(i.asset.duration)
            progressBar.setProgress(Float(time/siz), animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let documents = documents {
            let audio = documents[currentTrackNumber].audio
            audioNameLabel.text = audio?.filename
            api.getAudioUrl(String(audio!.id), completion: setAudioUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    func setAudioUrl(url: String!) {
        item = AVPlayerItem(URL: NSURL(string: url)!)
        player.replaceCurrentItemWithPlayerItem(item)
                //player.play()
    }

    @IBAction func nextTrackAction(sender: AnyObject) {
        if let documents = documents {
                  currentTrackNumber = (currentTrackNumber + 1) % documents.count
            let audio = documents[currentTrackNumber].audio
            audioNameLabel.text = audio?.filename
            playPauseButton.selected = false
            api.getAudioUrl(String(audio!.id), completion: setAudioUrl)
        }
        
    }
    
    
    @IBAction func previousTrackAction(sender: AnyObject) {
        if let documents = documents {
            playPauseButton.selected = false
            if currentTrackNumber > 0 {
                currentTrackNumber -= 1
                let audio = documents[currentTrackNumber].audio
                audioNameLabel.text = audio?.filename
                api.getAudioUrl(String(audio!.id), completion: setAudioUrl)
            } else {
                player.seekToTime(CMTimeMake(0,1))
            }
        }
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
