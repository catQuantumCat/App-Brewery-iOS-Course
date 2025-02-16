//
//  HomeVC.swift
//  Todoey-XIB
//
//  Created by Huy on 7/1/25.
//

import RealmSwift
import UIKit

class HomeVC: UIViewController {
    private var todoList: Results<TodoModel>?
    private let realm = try! Realm()
    
    private var category: CategoryModel?
    private var parentColor: UIColor = .white

    @IBOutlet var todoListTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    init(category: CategoryModel?) {
        
        if let category  {
            self.parentColor = UIColor(hex: category.color) ?? .white
        }
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navbarSetup()
        searchBarSetup()
    }
}

extension HomeVC {
    private func setup() {
        tableSetup()
        getData()
    }
}

// MARK: - Button events

extension HomeVC {
    @objc private func addButtonPressed() {
        var textField = UITextField()

        let alert = UIAlertController(title: "New todo", message: nil, preferredStyle: .alert)
        
        alert.addTextField { field in
            textField = field
        }

        let alertAction = UIAlertAction(title: "Add", style: .default) { _ in
            if (textField.text?.isEmpty ?? true){
                return
            }
            if self.category != nil{
                self.saveData {
                    let newTodo = TodoModel(title: textField.text ?? "")
                    self.category!.todos.append(newTodo)
                }
            }
            self.todoListTableView.reloadData()
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - SEARCH BAR

extension HomeVC: UISearchBarDelegate {
    private func searchBarSetup() {
        searchBar.delegate = self
        searchBar.barTintColor = parentColor
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
                
            
            textField.backgroundColor = .white
            }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData(with: searchBar.text ?? "")
    }
}

// MARK: - TABLE

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    private func tableSetup() {
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        todoListTableView.register(UINib(nibName: "TodoListCellVC", bundle: nil), forCellReuseIdentifier: "listID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listID", for: indexPath) as? TodoListCellVC {
            if (todoList != nil){
                
                let gradientPercentage = 1 - (CGFloat(indexPath.row) / CGFloat(todoList!.count))
                
                
                
                cell.configure(with: todoList![indexPath.row], color: parentColor.withAlphaComponent(gradientPercentage))
            }
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "listID")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let todo = todoList?[indexPath.row]{
            saveData {
                todo.status = !todo.status
            }
            
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let todo = todoList?[indexPath.row], editingStyle == .delete {
            saveData {
                realm.delete(todo)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - data processing

extension HomeVC {
    private func saveData(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
            
        } catch {
            print("Error while saving data: \(error)")
        }
    }

    private func getData(){
        todoList = self.category?.todos.sorted(byKeyPath: "createdDate", ascending: false)
        todoListTableView.reloadData()
        
    }

    private func searchData(with keyword: String) {
        if (keyword.isEmpty) {
            getData()

        }
        else{
            todoList = todoList?.filter("title CONTAINS[cd] %@", keyword)
            todoListTableView.reloadData()
        }
    }
}

// MARK: Navbar setup

extension HomeVC {
    private func navbarSetup() {
        
        guard let navigationController else {return}
        
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = parentColor
        
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: parentColor.contrastColor
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: parentColor.contrastColor
        ]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        navigationController.navigationBar.tintColor = parentColor.contrastColor
        
        navigationItem.largeTitleDisplayMode = .always

        navigationItem.title = category?.name ?? "Items"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonPressed)
        )
    }
}


