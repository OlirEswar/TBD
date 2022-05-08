//
//  HomePageViewController.swift
//  TBD_Codepath
//
//  Created by Oliravan Eswaramoorthy on 5/4/22.
//

import UIKit
import Firebase
import FirebaseAuth

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email!)!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.data()!)
                let data = document.data()
                let totalGroups = data!["groups"] as! Array<Any>
                self.count = totalGroups.count
                print("---------", self.count)
                self.tableView.reloadData()
            } else {
                print("document does not exist")
            }
        }
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        }
        catch let signoutError {
            self.present(Service.createAlertController(
                title: "Error",
                message: signoutError.localizedDescription),
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func onAdd(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email!)!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.data()!)
                let data = document.data()
                let totalGroups = data!["groups"] as! Array<Any>
                self.count = totalGroups.count
                print("---------", self.count)
            } else {
                print("document does not exist")
            }
        }
        return self.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell") as! GroupTableViewCell
        let db = Firestore.firestore()
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email!)!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.data()!)
                let data = document.data()
                var totalGroups = data!["groups"] as! Array<String>
                cell.titleLabel?.text = totalGroups[indexPath.row] as! String
                cell.descriptionLabel.text = "Edit your group info to enter a brief description. This could be a fun nickname, your group's purpose, or anything else you want it to be!"
            } else {
                print("document does not exist")
            }
        }
        
        return cell
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
