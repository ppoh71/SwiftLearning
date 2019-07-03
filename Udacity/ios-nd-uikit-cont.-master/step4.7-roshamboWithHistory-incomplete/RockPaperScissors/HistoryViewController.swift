//
//  HistroryViewController.swift
//  RockPaperScissors
//
//  Created by Peter Pohlmann on 21.10.18.
//  Copyright © 2018 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Properties
    
    var history = [RPSMatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func dismiss(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")!
        let match = self.history[(indexPath as NSIndexPath).row]
        
        //set data
        cell.textLabel?.text =  match.winner.description + " " + victoryModeString(match.winner) + " " + match.loser.description + ". " + resultString(match)
        cell.imageView?.image = imageForMatch(match)
        
        return cell
    }
    
    
    func messageForMatch(_ match: RPSMatch) -> String {
        
        // Handle the tie
        if match.p1 == match.p2 {
            return "It's a tie!"
        }
        
        // Here we build up the results message "RockCrushesScissors. You Win!" etc.
        return match.winner.description + " " + victoryModeString(match.winner) + " " + match.loser.description + ". " + resultString(match)
    }
    
    func resultString(_ match: RPSMatch) -> String {
        return match.p1.defeats(match.p2) ? "You Won!" : "You Lost!"
    }
    
    func victoryModeString(_ gesture: RPS) -> String {
        switch (gesture) {
        case .rock:
            return "crushed"
        case .scissors:
            return "cut"
        case .paper:
            return "covered"
        }
    }
    
    // MARK: Image for Match
    
    func imageForMatch(_ match: RPSMatch) -> UIImage {
        
        var name = ""
        
        switch (match.winner) {
        case .rock:
            name = "RockCrushesScissors"
        case .paper:
            name = "PaperCoversRock"
        case .scissors:
            name = "ScissorsCutPaper"
        }
        
        if match.p1 == match.p2 {
            name = "itsATie"
        }
        return UIImage(named: name)!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
