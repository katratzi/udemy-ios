//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
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
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()

    }
    
    func loadMessages() {
        
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener {
            (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("Issue retrieving data \(e)")
            } else {
                 if let snapshotDocuments =  querySnapshot?.documents
                {
                     for doc in snapshotDocuments {
                         print(doc.data())
                         let data = doc.data()
                         if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                             let message = Message(sender: messageSender, body: messageBody)
                             self.messages.append(message)
                             
                             // force a reload
                             DispatchQueue.main.async {
                                 self.tableView.reloadData()
                                 // index path to last element and we only have 1 section
                                 let indexPath = IndexPath(row: self.messages.count - 1 , section: 0)
                                 self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                             }
                             
                         }
                     }
                     
                 }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        // get message and sender if not nil
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email
        {
            db.collection(K.FStore.collectionName)
                .addDocument(data: [K.FStore.senderField: messageSender,
                                    K.FStore.bodyField: messageBody,
                                    K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("Error saving to firestore \(e)")
                } else {
                    print("success saving data")
                    
                    DispatchQueue.main.async {
                        // clear text
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    
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
        let message = messages[indexPath.row]
        
        // create the visual
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        // cell.textLabel?.text = "\(indexPath.row) This is a cell "
        cell.label.text = message.body
        
        // this is a message from current user
        if(message.sender == Auth.auth().currentUser?.email){
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else { // message from other sender
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
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
