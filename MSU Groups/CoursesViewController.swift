//
//  CoursesViewController.swift
//  MSU Groups
//
//  Created by Zach Arnold on 12/8/20.
//

import UIKit
import Parse

class CoursesViewController: UIViewController,
                             UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var codeBar: UISearchBar!
    
    @IBOutlet weak var numberBar: UISearchBar!
    
    var courses = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let textCodeBar = self.codeBar.value(forKey: "searchField") as? UITextField

        textCodeBar?.textColor = UIColor.white
        
        let textNumberBar = self.numberBar.value(forKey: "searchField") as? UITextField

        textNumberBar?.textColor = UIColor.white
              
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        self.tableView.reloadData()
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        
        let query = PFQuery(className: "Course")
        query.includeKeys(["code", "number"])
        
        let courseCode = self.codeBar.text! as String
        let courseNum = Int(self.numberBar.text!) ?? 0
        
        
        if courseNum != 0 {
            query.whereKey("number", equalTo: courseNum)
        }
        query.whereKey("code", equalTo: courseCode)
        
        query.findObjectsInBackground { (courses, error) in
            if let error = error {
                print("Error: \(String(describing: error.localizedDescription))")
            } else {
                self.courses = courses ?? []
                self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as! CourseCell
        let course = courses[indexPath.row]
        
        let code = course["code"] as! String
        
        let num = course["number"] as! NSNumber
        
        let numString = num.stringValue
        
        cell.classCode.text = code + " " + numString
        
        return cell
    }


}
