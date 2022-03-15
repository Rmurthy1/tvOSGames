//
//  ProfileViewController.swift
//  tvOSGames
//
//  Created by Rahul Murthy on 2/27/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Thanks for using my app!", message: "There is no log in required, or server to log in to! Not yet anyway. Thanks!", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: NSLocalizedString("Dismiss", comment: "default action"), style: .default, handler: { _ in
            print("The \"Dismiss\" alert occured.") //nslog looks like a bit much
        })
        let clearAlertAction = UIAlertAction(title: NSLocalizedString("Clear Text Fields", comment: "clear text fields action"), style: .default, handler: { _ in
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
            print("The \"Clear\" alert occured.") //nslog looks like a bit much
        })
        alert.addAction(okAlertAction)
        alert.addAction(clearAlertAction)
        self.present(alert, animated: true, completion: nil)
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
