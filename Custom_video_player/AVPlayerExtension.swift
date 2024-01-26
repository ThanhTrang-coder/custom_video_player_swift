//
//  AVPlayerExtension.swift
//  Custom_video_player
//
//  Created by T.Trang on 26/01/2024.
//

import Foundation
import AVKit

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
