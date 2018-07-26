//
//  GameViewController.swift
//  Randomizly
//
//  Created by Nathaniel Idahosa on 29.05.18.
//  Copyright © 2018 Joseph. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    
    let model = RandomizlyModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.hintLabel.isHidden = true
    }
    
    
    @IBAction func guess(_ sender: Any) {
        // Check if the text field contains any value
        if let input = self.inputField.text, let number = Int(input) {
            let result = self.model.guess(number)
            let tries = self.model.tries
            switch result {
            case .correct:
                self.showAlert(title: "Victory", message: "You guessed the number correctly! Tries needed: \(tries)")
                self.model.newNumber()
                self.inputField.text = ""
                self.hintLabel.isHidden = true
            case .tooLow:
                self.inputField.text = ""
                self.hintLabel.text = "👆 HIGHER 📈"
                self.hintLabel.isHidden = false
            case .tooHigh:
                self.inputField.text = ""
                self.hintLabel.text = "👇 LOWER 📉"
                self.hintLabel.isHidden = false
            }
            print("Result: \(result), tries: \(tries)")
        } else {
            print("no input")
            self.inputField.text = ""
            self.showAlert(title: "Error", message: "Enter a number!")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
