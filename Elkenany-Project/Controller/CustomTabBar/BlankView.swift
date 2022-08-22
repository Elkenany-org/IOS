//
//  BlankView.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/16/22.
//

import UIKit
import AVFoundation
import AVKit


class BlankView: UIViewController {
//    var player: AVQueuePlayer?
    var videoLooper: AVPlayerLooper?

    @IBOutlet weak var videooooo: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        let url = URL(string:"")
//
//        player = AVPlayer(url: url!)
//
//        .player = player
//
//        BlankView.view.frame.size.height = videooooo.frame.size.height
//
//        BlankView.view.frame.size.width = videooooo.frame.size.width
//
//        self.videooooo.addSubview(BlankView.view)
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
    }
    
    
}
