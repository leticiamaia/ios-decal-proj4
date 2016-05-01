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

    var audio : Audio?
    
    let api = DitangoAPI()
    
    
    var player: AVPlayer!
    var item: AVPlayerItem?
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVPlayer()
        //player = AVPlayer(URL: NSURL(string: "http://repos.ditango.com.br/381/audio/audio.mp3")!)
        //player.play()
        // Do any additional setup after loading the view.
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
        //print(url)
        item = AVPlayerItem(URL: NSURL(string: url)!)
        player.replaceCurrentItemWithPlayerItem(item)
        //print(player.currentItem)
        print("chegouaqui")
        player.play()
        print("saiuuu")
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
