//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = [
        Message(sender: "hello@hello.com", body: "Hey"),
        Message(sender: "a@b.com", body: "Hello"),
        Message(sender: "hello@hello.com", body: "What's Up")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the back button
        navigationItem.hidesBackButton = true
        title = K.appName
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            // want to go all the way back to the start
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

// protocol for filling in data
extension ChatViewController : UITableViewDataSource {
    
    // how many cells are there
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // in our case no of messages
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        // cell.textLabel?.text = "\(indexPath.row) This is a cell "
        cell.textLabel?.text = messages[indexPath.row].body
        
        return cell
    }
    
}

extension ChatViewController : UITableViewDelegate {
    
    // what happens when we select a cell
    // we've made them unselectable in the project
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
