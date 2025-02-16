//
//  CategoryVC.swift
//  Todoey-XIB
//
//  Created by Huy on 6/2/25.
//

import CoreData
import RealmSwift
import UIKit

class CategoryVC: UIViewController {
    // MARK: PROPERTIES
    
    let realm = try! Realm()
    
    var categories: Results<CategoryModel>?
    
    // MARK: IB PROPERTIES

    @IBOutlet var categoryTableView: UITableView!
    
    // MARK: VIEWDIDLOAD()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        categoryTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarSetup()
    }
}

// MARK: - SETUP

extension CategoryVC {
    private func setup() {
        tableSetup()
    }
}

// MARK: - NAVIGATION

extension CategoryVC {
    private func openOneCategory(with category: CategoryModel?) {
        let vc = HomeVC(category: category)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TABLE

extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    private func tableSetup() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.register(UINib(nibName: Constants.categoryCellNibName, bundle: nil), forCellReuseIdentifier: Constants.categoryCellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: Constants.categoryCellReuseIdentifier) as! CategoryCell
        
            
        cell.configure(with: categories?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openOneCategory(with: categories?[indexPath.row])
        categoryTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeCategory(with: categories?[indexPath.row])
            categoryTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - NAVBAR

extension CategoryVC {
    private func navBarSetup() {
        
        guard let categories = categories, let navigationController = navigationController else { return }
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        
        let color = UIColor(hex: categories.first?.color ?? "") ?? .white
        
        appearance.backgroundColor = color
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: color.contrastColor
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: color.contrastColor
        ]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonPressed)
            
        )
        navigationController.navigationBar.tintColor = color.contrastColor
        navigationItem.title = "Todoey"
    }
    
    @objc private func addButtonPressed() {
        showAddAlert()
    }
}

// MARK: - ALERT

extension CategoryVC {
    private func showAddAlert() {
        var textField = UITextField()
        let alert = UIAlertController(title: "New category", message: nil, preferredStyle: .alert)
            
        alert.addTextField { field in
            textField = field
        }
        let alertAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let text = textField.text, text.isEmpty { return }
            self.addCategory(name: textField.text ?? "")
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

// MARK: - DATA

extension CategoryVC {
    private func loadData() {
        categories = realm.objects(CategoryModel.self)
    }
    
    private func writeToRealm(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print("Error while saving categories: \(error)")
        }
    }
    
    private func saveData(category: CategoryModel) {
        writeToRealm {
            realm.add(category)
        }
    }
    
    private func addCategory(name: String) {
        let newCategory = CategoryModel()
        newCategory.name = name
        newCategory.color = UIColor.random.hexString
        saveData(category: newCategory)
        categoryTableView.reloadData()
    }
    
    private func removeCategory(with category: CategoryModel?) {
        if let categoryToDelete = category {
            writeToRealm {
                realm.delete(categoryToDelete)
            }
        }
    }
}
