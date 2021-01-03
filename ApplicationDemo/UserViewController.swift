//
//  UserViewController.swift
//  ApplicationDemo
//
//  Created by YOGESH BANSAL on 02/01/21.
//

import UIKit
import CoreData


class UserTableViewCell: UITableViewCell {

    
    @IBOutlet var city: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    
    var onDelete: (() -> Void) = {  }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func onDelete(_ sender: UIButton) {
        onDelete()
    }
    
    
}



class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    @IBOutlet var tableView: UITableView!
    var users: [UserData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    
    func fetchData() {
      
            print("Fetching Data..")
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                self.users =  (result as! [NSManagedObject]).map({UserData(UserDBObj: $0)}).reversed()
                print(users.count)
                tableView.reloadData()
                
            } catch {
                print("Fetching data Failed")
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = users[indexPath.row].firstName + " " + users[indexPath.row].lastName
        cell.nameLabel.textColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        cell.gender.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.city.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.profilePic.layer.cornerRadius = cell.profilePic.bounds.size.width / 2
        cell.profilePic?.image = user.image
        cell.gender.text = users[indexPath.row].gender
        cell.city.text = users[indexPath.row].country
        cell.onDelete = {
            user.deleteUser(context: self.context) { (isDelete) in
                if (isDelete) {
                    self.fetchData()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
