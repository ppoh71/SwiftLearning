//
//  RockResultController.swift
//  roshambo
//
//  Created by Peter Pohlmann on 09.09.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

class RockResultController: UIViewController {

   
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var winLabel: UILabel!
    enum Game: Int {case rock = 0, scissor, paper}
    enum Result: Int{case winRock=0, winScissor, winPaper, tie}
    enum Win: Int{case lose=0, win, tie}
    var player1 = 0
    var player2 = 0
    var gameResult:Result = .tie
    var win:Win = .tie
    var winMsg = "You won!"
    var loseMsg = "You lose!"
    var tieMsg = "It's a tie!"
    
    @IBAction func startOver(_ sender: Any) {
        if let navigationController = navigationController{
            navigationController.popToRootViewController(animated: true)
        }
    }

    func playGame(){
        player2 = Int(arc4random_uniform(3) + 0)
        print(player1)
        print(player2)
        
        switch(player1){
        case 0:
            if player2 == 1 {
                gameResult = .winRock
                win = .win
            }
            if player2 == 2 {
                gameResult = .winPaper
                win = .lose
            }
        case 1:
            if player2 == 0 {
                gameResult = .winRock
                win = .lose
            }
            if player2 == 2 {
                gameResult = .winScissor
                win = .win
            }
        case 2:
            if player2 == 0 {
                gameResult = .winPaper
                win = .win
            }
            if player2 == 1 {
                gameResult = .winScissor
                win = .lose
            }
            
        default:
            gameResult = .tie
            win = .tie
        }
      
        switch(gameResult){
        case .winRock:
            resultImage.image = UIImage(named: "RockCrushesScissors")
        case .winScissor:
            resultImage.image = UIImage(named: "ScissorsCutPaper")
        case .winPaper:
            resultImage.image = UIImage(named: "PaperCoversRock")
        case .tie:
            resultImage.image = UIImage(named: "itsATie")
        }
        
        switch(win){
        case .lose:
            winLabel.text = loseMsg
        case .win:
            winLabel.text = winMsg
        case .tie:
            winLabel.text = tieMsg
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playGame()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
