//
//  ViewController.swift
//  ApplicationDemo
//
//  Created by YOGESH BANSAL on 02/01/21.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var enrollLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var indicatorView: UIView!
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    var isControllerSet = false
    
    private var usersTableViewController: UserViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        leadingConstraint.constant = scrollView.contentOffset.x / 2
        self.userLabel.textColor = leadingConstraint.constant < 100 ? #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.enrollLabel.textColor = leadingConstraint.constant > 100 ? #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        if leadingConstraint.constant == 0 && !isControllerSet {
            
            
           // usersTableViewController.fetchData()

        }
        
        isControllerSet = leadingConstraint.constant == 0
        
        indicatorView.layoutIfNeeded()
        //print("-----------\(scrollView.contentOffset)")
//        leadingConstraint.constant = scrollView.contentInset.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableView"  {
            if let viewController1 = segue.destination as? UserViewController {
                self.usersTableViewController = viewController1
                
            }
            
        } 
    }

}

