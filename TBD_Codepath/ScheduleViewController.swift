//
//  ScheduleViewController.swift
//  TBD_Codepath
//
//  Created by Oliravan Eswaramoorthy on 5/7/22.
//

import UIKit
import Firebase
import FirebaseAuth

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var scheduleTable: UITableView!
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scheduleTable.dataSource = self
        scheduleTable.delegate = self
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document((Auth.auth().currentUser?.email!)!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.data()!)
                let data = document.data()
                let totalGroups = data!["groups"] as! Array<Any>
                self.count = totalGroups.count
                print("---------", self.count)
                self.scheduleTable.reloadData()
            } else {
                print("document does not exist")
    }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let times = ["06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM", "08:00 AM", "08:30 AM", "09:00 AM",
                        "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM",
                        "01:00 PM", "01:30 PM", "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM",
                        "04:30 PM", "05:00 PM", "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM",
                        "08:00 PM", "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM",
                        "11:30 PM", "12:00 AM", "12:30 AM", "01:00 AM"]
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let times = ["06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM", "08:00 AM: Meet at Train station", "08:30 AM", "09:00 AM",
                        "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM: Arrive at Penn station", "11:30 AM", "12:00 PM", "12:30 PM: Lunch!",
                        "01:00 PM", "01:30 PM", "02:00 PM: Explore the City", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM",
                        "04:30 PM", "05:00 PM", "05:30 PM", "06:00 PM: Meet on Train back", "06:30 PM", "07:00 PM", "07:30 PM",
                        "08:00 PM", "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM",
                        "11:30 PM", "12:00 AM", "12:30 AM", "01:00 AM"]
        cell.textLabel?.text = times[indexPath.row]
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
