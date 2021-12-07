//
//  SplashScreenViewController.swift
//  Coco
//
//  Created by Leonidas Acosta on 11/29/21.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var mathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(name: "cocomel")
        let yAtStart = imageView.frame.origin.y
        let mAtStart = mathLabel.frame.origin.y
        imageView.frame.origin.y = self.view.frame.height
        mathLabel.frame.origin.y = self.view.frame.height
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {self.imageView.frame.origin.y = yAtStart})
        UIView.animate(withDuration: 1.0, delay: 2.0, animations: {self.mathLabel.frame.origin.y = mAtStart})
    }
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: \(error.localizedDescription) Could not initialize AVAudioPlayer object.")
            }
        } else {
            print("ERROR: Could not read data from file name: \(name)")
        }
    }
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        performSegue(withIdentifier: "ShowLogin", sender: nil)
    }
}
