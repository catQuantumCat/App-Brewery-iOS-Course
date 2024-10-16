
//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestoreInternal
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!
    
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    let db = Firestore.firestore()
    var messages: [MessageModel] = []
    let currentUser = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard let email = Auth.auth().currentUser?.email,
              let body = messageTextfield.text else { return }
        
        let data : [String : Any] = [
            Constants.FStore.senderField: email,
            Constants.FStore.bodyField: body,
            Constants.FStore.dateField: Date().timeIntervalSince1970
        ]
        
        db.collection(Constants.FStore.collectionName).addDocument(data: data) { error in
            if let error {
                print(error)
            } else {
                self.messageTextfield.text = ""
            }
        }
        
//        updateData()
    }

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let e as NSError {
            print(e)
            return
        }
        
        navigationController?.popToRootViewController(animated: false)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.configure(with: messages[indexPath.row], isSelf: messages[indexPath.row].sender == currentUser)
        
        
        
        return cell
    }
}

extension ChatViewController {
    private func setup() {
        navigationItem.setHidesBackButton(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        setupNotificationCenter()
    }
    
    private func setupNotificationCenter(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func fetchData() {
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            
            if let error {
                print("Error: \(error)")
                return
            }
            guard let querySnapshot else {
                return
            }
            
            let dataList = querySnapshot.documents.map { data in
                data.data()
            }
                        
            self.messages = MessageModel.toListMessage(from: dataList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.layoutIfNeeded()
                self.tableView.scrollToBottom()
            }
        }
    }
}





extension ChatViewController{
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            messageViewBottomConstraint.constant = keyboardRectangle.height
        }
        
        UIView.animate(withDuration: 1, delay: 0, animations: {self.view.layoutIfNeeded()})
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        messageViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0, animations: {self.view.layoutIfNeeded()})
    }
}
