//
//  EasyGameViewController.swift
//  Coco
//
//  Created by Leonidas Acosta on 11/30/21.
//

import UIKit
import youtube_ios_player_helper

class EasyGameViewController: UIViewController {
    @IBOutlet weak var missedProblemsLabel: UILabel!
    @IBOutlet weak var correctProblemsLabel: UILabel!
    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var pinkFongImage: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    var problems = ["3 + 2", "3 + 3", "1 + 1"]
    var videos = ["WRVsOCh907o", "wTNJZEcHdPw", "4IncKbbQRh4", "Wm4R8d0d8kU", "WNBJA-xDSXk", "SsauwGdDMys", "XqZsoesa55w"]
    var currentProblemIndex = 0
    var missedProblemsCount = 0
    var correctProblemsCount = 0
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    let maxNumberMissedProblems = 3
    var childs: Childs!
    override func viewDidLoad() {
        super.viewDidLoad()
        childs = Childs()
        problemLabel.text = problems[0]
        random()
        updateUserInterface()

    }
    func random() {
        let video = videos.randomElement()!
        playerView.load(withVideoId: "\(video)")
    }
    func play() {
        if firstChoiceButton.isHidden && secondChoiceButton.isHidden && thirdChoiceButton.isHidden == true {
            problemLabel.isHidden = true
            playerView.isHidden = false
//            playerView.playVideo()
            random()

        }
    }
    func over() {
        if missedProblemsCount == maxNumberMissedProblems {
            gameOverLabel.isHidden = false
            pinkFongImage.isHidden = false
            playAgainButton.isHidden = false
        }
        
    }

    func updateGameStatusLabels() {
        missedProblemsLabel.text = "Missed Problems: \(missedProblemsCount)"
        correctProblemsLabel.text = "Correct Problems: \(correctProblemsCount)"
    }

    
    @IBAction func playAgainButton(_ sender: UIButton) {
        problemLabel.text = problems[0]
        missedProblemsCount = 0
        correctProblemsCount = 0
        updateGameStatusLabels()

        firstChoiceButton.isHidden = false
        secondChoiceButton.isHidden = false
        thirdChoiceButton.isHidden = false
        problemLabel.isHidden = false
        playAgainButton.isHidden = true
        pinkFongImage.isHidden = true
        gameOverLabel.isHidden = true
        play()
        over()
    }
    
    @IBAction func firstChoiceButtonPressed(_ sender: UIButton) {
        if problemLabel.text == "1 + 1" {
            correctProblemsCount += 1
            firstChoiceButton.isHidden = true
            play()
            updateGameStatusLabels()
        } else if problemLabel.text != "1 + 1" {
            missedProblemsCount += 1
            updateGameStatusLabels()
            over()
        }
    }
    @IBAction func secondChoiceButtonPressed(_ sender: UIButton) {
        if problemLabel.text == "3 + 2" {
            correctProblemsCount += 1
            secondChoiceButton.isHidden = true
            problemLabel.text = problems[1]
            play()
            updateGameStatusLabels()
        } else if problemLabel.text != "3 + 2" {
            missedProblemsCount += 1
            updateGameStatusLabels()
            over()
        }
    }

    @IBAction func thirdChoiceButtonPressed(_ sender: UIButton) {
        if problemLabel.text == "3 + 3" {
            correctProblemsCount += 1
            updateGameStatusLabels()
            thirdChoiceButton.isHidden = true
            problemLabel.text = problems[2]
            play()
        } else if problemLabel.text != "3 + 3" {
            missedProblemsCount += 1
            updateGameStatusLabels()
            over()
            
        }
    }
    func updateUserInterface() {
        playerView.isHidden = true
    }
}
