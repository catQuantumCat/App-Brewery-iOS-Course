//
//  HomeVC.swift
//  Todoey-XIB
//
//  Created by Huy on 7/1/25.
//

import UIKit

class HomeVC: UIViewController {
    
    private let dummyData : [TodoModel] = [TodoModel(title: "Task 1", false), TodoModel(title: "Task 2", true)]

    @IBOutlet weak var todoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}


extension HomeVC{

    private func setup(){
        
        tableSetup()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.title = "Todoey"
        
        
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.backgroundColor = UIColor.systemBlue
        
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance

        
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

    }
    
    private func tableSetup(){
        self.todoListTableView.delegate = self
        self.todoListTableView.dataSource = self
        
        todoListTableView.register(UINib(nibName: "TodoListCellVC", bundle: nil), forCellReuseIdentifier: "listID")
    }
    
    
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listID", for: indexPath) as! TodoListCellVC
        
        cell.configure(with: dummyData[indexPath.row])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let cell = tableView.cellForRow(at: indexPath) as! TodoListCellVC
        cell.onTap()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
