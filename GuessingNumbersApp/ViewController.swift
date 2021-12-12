//
//  ViewController.swift
//  GuessingNumbersApp
//
//  Created by Ferdi DEMİRCİ on 11.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var random: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var star: UILabel!
    
    var correct = 0
    var heart = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDefaultData()
    }

    func loadDefaultData() {
        guessButton.layer.cornerRadius = 6
        random.text = "?"
        message.text = ""
        star.text = "★★★"
        heart = 3
        correct = Int(arc4random_uniform(100))
    }
    
    func defaultAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
            self.loadDefaultData()
        }))
        alert.addAction(UIAlertAction(title: "Don't", style: .destructive, handler: { action in
            print("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func heartState(heart:Int) {
        switch heart {
        case 3:
            star.text = "★★★"
        case 2:
            star.text = "★★"
        case 1:
            star.text = "★"
        default:
            print("")
        }
    }
    
    func helpMessage(number:Int) {
        message.text = correct > number ? "İncrease" : "Decrease"
    }
    
    @IBAction func guessActionButton(_ sender: Any) {
        print(correct)
        let numberStore = numberTextField.text ?? ""
        if let number = Int(numberStore) {
           helpMessage(number: number)
            if correct == number {
                print("Doğru tahmin ettiniz.")
                random.text = "\(correct)"
                defaultAlert(title: "You found the number", message: "Congratulations!")
            }
            else {
                heart -= 1
                if heart < 1 {
                    print("Game over")
                    random.text = "\(correct)"
                    defaultAlert(title: "Game Over", message: "Try again")
                }
                heartState(heart: heart)
            }
        }
        numberTextField.text = ""
    }
    
}

