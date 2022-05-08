//
//  HomePageViewController.swift
//  TBD_Codepath
//
//  Created by Oliravan Eswaramoorthy on 5/4/22.
//
//  FOR THE ADDING PAGE

import UIKit
import Firebase
import FirebaseAuth

class AddViewController: UIViewController {

    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var foundUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user.text = Auth.auth().currentUser?.email
    }
    

    @IBAction func addUserTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userNameTextField.text!)
        print("!!!!!!!!!!", docRef)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.data()!)
                var data = document.data()
                self.foundUser.text = data!["name"] as! String
            } else {
                print("document does not exist")
            }
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
