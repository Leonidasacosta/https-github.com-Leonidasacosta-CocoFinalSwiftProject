//
//  HardGameViewController.swift
//  Coco
//
//  Created by Leonidas Acosta on 12/3/21.
//

import UIKit
import youtube_ios_player_helper

class HardGameViewController: UIViewController {
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var pinkImage: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var missedProblemsLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var correctProblemsLabel: UILabel!
    @IBOutlet var playerView: YTPlayerView!
    var problems = ["15 + 15", "5 + 10", "30 + 20"]
    var videos = ["WRVsOCh907o", "wTNJZEcHdPw", "4IncKbbQRh4", "Wm4R8d0d8kU", "WNBJA-xDSXk", "SsauwGdDMys", "XqZsoesa55w"]
    var missedProblemsCount = 0
    let maxNumberMissedProblems = 3
    var correctProblemsCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        random()
        playerView.isHidden = true
        problemLabel.text = problems[0]
        updateUserInterface()
    }
    
    func random() {
        let video = videos.randomElement()!
        playerView.load(withVideoId: "\(video)")
        let randomProblems = problems.randomElement()!
        problemLabel.text = "\(randomProblems)"
    }
    
    func play() {
        if firstButton.isHidden && secondButton.isHidden && thirdButton.isHidden == true {
            problemLabel.isHidden = true
            playerView.isHidden = false
//            playerView.playVideo()
            random()
        }
        
    }
    func over() {
        if missedProblemsCount == maxNumberMissedProblems {
            gameOverLabel.isHidden = false
            pinkImage.isHidden = false
            playAgainButton.isHidden = false
        }
    }
    func updateGameStatusLabels() {
        missedProblemsLabel.text = "Missed Problems: \(missedProblemsCount)"
        correctProblemsLabel.text = "Correct Problems: \(correctProblemsCount)"
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton){
        problemLabel.text = problems[0]
        missedProblemsCount = 0
        correctProblemsCount = 0
        updateGameStatusLabels()
        
        firstButton.isHidden = false
        secondButton.isHidden = false
        thirdButton.isHidden = false
        problemLabel.isHidden = false
        playAgainButton.isHidden = true
        pinkImage.isHidden = true
        gameOverLabel.isHidden = true
        play()
        over()
    }
    
    
    @IBAction func firstButtonPressed(_ sender: UIButton) {
        if problemLabel.text == "15 + 15" {
            correctProblemsCount += 1
            updateGameStatusLabels()
            firstButton.isHidden = true
            problemLabel.text = problems[1]
            play()
        } else if problemLabel.text != "15 + 15" {
            missedProblemsCount += 1
            updateGameStatusLabels()
            over()
        }
    }
    @IBAction func secondButtonPressed(_ sender: UIButton) {
        if problemLabel.text == "30 + 20" {
            correctProblemsCount += 1
            updateGameStatusLabels()
            secondButton.isHidden = true
            play()
        } else if problemLabel.text != "30 + 20" {
            missedProblemsCount += 1
            updateGameStatusLabels()
            over()
        }
    }
    @IBAction func thirdButtonPressed(_ sender: UIButton) {
        if problemLabel.text == "5 + 10" {
            correctProblemsCount += 1
            updateGameStatusLabels()
            thirdButton.isHidden = true
            problemLabel.text = problems[2]
            play()
        } else if problemLabel.text != "5 + 10" {
            missedProblemsCount += 1
            updateGameStatusLabels()
            over()
        }
    }
    func updateUserInterface() {
        playerView.isHidden = true
    }
}
