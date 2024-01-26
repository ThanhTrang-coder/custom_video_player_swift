//
//  ViewController.swift
//  Custom_video_player
//
//  Created by Tung on 26/01/2024.
//

import UIKit
import AVKit

class ViewController: UIViewController, UIScrollViewDelegate{
    var url: String = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playOrPauseBtn: UIButton!

    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer? = nil
    private var pinchGestureRecognizer: UIPinchGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpPlayer()
    
    }

    @IBAction func playOrPause(_ sender: Any) {
        print("play video")
        guard let player = player else { return }
        if player.isPlaying {
            player.pause()
            playOrPauseBtn.setTitle("Pause", for: .normal)
        } else {
            player.rate = 1
            playOrPauseBtn.setTitle("Play", for: .normal)
        }
    }
    
    private func setUpPlayer() {
        if player == nil {
            guard let videoUrl = URL(string: url) else { return }
            let playerItem = AVPlayerItem(url: videoUrl)
            player = AVPlayer(playerItem: playerItem)
            playerLayer = AVPlayerLayer(player: player)
            playerView.layer.addSublayer(playerLayer!)
            playerLayer?.videoGravity = .resizeAspectFill

            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            playerView.addGestureRecognizer(pinchGesture)
            playerLayer?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 580)
            player?.play()
            
        }
    }
    
    @objc private func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard let playerLayer = playerLayer else {
            return
        }
        
        switch gestureRecognizer.state {
        case .began: break
                // Do nothing on pinch begin

        case .changed:
            let scale = gestureRecognizer.scale

            // Apply the scale transformation to the player layer
            var currentTransform = playerLayer.transform
            currentTransform = CATransform3DScale(currentTransform, scale, scale, 1.0)
            playerLayer.transform = currentTransform

            // Reset the scale to 1 to avoid cumulative scaling
            gestureRecognizer.scale = 1.0
            
        default: break
        }
    }
}
