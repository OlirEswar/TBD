//
//  GroupCreationViewController.swift
//  TBD_Codepath
//
//  Created by Oliravan Eswaramoorthy on 5/4/22.
//

import UIKit
import Firebase
import FirebaseAuth

class GroupCreationViewController: UIViewController {

    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var foundUser: UILabel!
    @IBOutlet weak var groupName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                self.foundUser.text = "Sorry, user wasn't found..."
                print("document does not exist")
            }
        }
    }
    
    @IBAction func groupCreateTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userNameTextField.text!)
        docRef.updateData(["groups": FieldValue.arrayUnion([ groupName.text ])])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
