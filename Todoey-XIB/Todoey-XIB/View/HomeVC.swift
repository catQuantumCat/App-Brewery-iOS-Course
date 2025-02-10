//
//  HomeVC.swift
//  Todoey-XIB
//
//  Created by Huy on 7/1/25.
//

import CoreData
import UIKit

class HomeVC: UIViewController {
    private var dummyData: [TodoModel] = []
    
    
    private var category : CategoryModel?{
        didSet
        {
            dummyData = getData()
        }
    }
    
    private let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet var todoListTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    init(category: CategoryModel) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension HomeVC {
    private func setup() {
        tableSetup()
        navbarSetup()
        searchBarSetup()
        dummyData = getData()
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
           
            let newTodo = TodoModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
            
            newTodo.title = textField.text ?? ""
            newTodo.status = false
            newTodo.category = self.category
            
            self.dummyData.append(newTodo)
            self.saveData()
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let text = searchBar.text, text.isEmpty{
            return
        }
        
        dummyData = searchData(with: searchBar.text ?? "")
        todoListTableView.reloadData()
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
        dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listID", for: indexPath) as? TodoListCellVC {
            cell.configure(with: dummyData[indexPath.row])
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "listID")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dummyData[indexPath.row].status = !dummyData[indexPath.row].status
        
        saveData()
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - data processing

extension HomeVC {
    private func saveData() {
        do {
            try coreDataContext.save()
            
        } catch {
            print("Error while saving data: \(error)")
        }
    }

    private func getData(with request: NSFetchRequest<TodoModel> = TodoModel.fetchRequest(), predicate: NSPredicate? = nil) -> [TodoModel] {
        
        if let category{
            let categoryPredicate = NSPredicate(format: "category.name MATCHES %@", category.name ?? "")
            
            if let predicate = predicate{
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, categoryPredicate])
            }
            else{
                request.predicate = categoryPredicate
            }
        }

        do {
            return try coreDataContext.fetch(request)
    
        } catch {
            print("Error getting data: \(error)")
            return []
        }
    }

    private func deleteData(at index: Int) {
        coreDataContext.delete(dummyData[index])
        dummyData.remove(at: index)
        saveData()
    }
    
    private func searchData(with keyword: String) -> [TodoModel] {
        let request: NSFetchRequest<TodoModel> = TodoModel.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", keyword)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return getData(with: request, predicate: predicate)
    }
}

// MARK: Navbar setup

extension HomeVC {
    private func navbarSetup() {
        guard let navigationController = navigationController else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        
        
        navigationItem.title = "Item"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonPressed)
        )
        
        
        let navbar = navigationController.navigationBar
        navbar.prefersLargeTitles = false
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
    }
}
