//
//  SignUpViewController.swift
//  TBD_Codepath
//
//  Created by Oliravan Eswaramoorthy on 5/4/22.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
        if email.text?.isEmpty == true {
            print("no text in email field")
            return
        }
        
        if password.text?.isEmpty == true {
            print("no text in password field")
        }
        
        signUp()
            
    }
    
    @IBAction func alreadyHaveAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users").document(Auth.auth().currentUser!.email!).setData(
                    ["name":user.email as Any,
                       "uid":user.uid as Any,
                       "groups": [] ])
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "home")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
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
