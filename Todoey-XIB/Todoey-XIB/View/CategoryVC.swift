//
//  CategoryVC.swift
//  Todoey-XIB
//
//  Created by Huy on 6/2/25.
//

import CoreData
import UIKit

class CategoryVC: UIViewController {
    // MARK: PROPERTIES

    let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories: [CategoryModel] = []

    // MARK: IB PROPERTIES

    @IBOutlet var categoryTableView: UITableView!
    
    // MARK: VIEWDIDLOAD()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        categories = loadData()
        categoryTableView.reloadData()
        
    }
}

// MARK: - SETUP

extension CategoryVC {
    private func setup() {
        tableSetup()
        navBarSetup()
    }
}

//MARK: - NAVIGATION

extension CategoryVC {
    private func openOneCategory(with category: CategoryModel){
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
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: Constants.categoryCellReuseIdentifier) as! CategoryCell
        
        cell.configure(title: categories[indexPath.row].name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openOneCategory(with: categories[indexPath.row])
        categoryTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - NAVBAR
extension CategoryVC {
    private func navBarSetup() {
        guard let navigationController = navigationController else { return }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonPressed)
        )
                
        navigationItem.title = "Todoey"

        let navbar = navigationController.navigationBar
        navbar.prefersLargeTitles = false
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
    }
    
    @objc private func addButtonPressed() {
        self.showAddAlert()
        
    }
}

//MARK: - ALERT
extension CategoryVC{
    
    private func showAddAlert()
        {
            var textField = UITextField()
            let alert = UIAlertController(title: "New category", message: nil, preferredStyle: .alert)
            
            alert.addTextField { field in
                textField = field
            }
            let alertAction = UIAlertAction(title: "Add", style: .default) { _ in
                
                if let text = textField.text, text.isEmpty { return }
                
                let category = self.addCategory(name: textField.text ?? "")
                self.categories.append(category)
                self.categoryTableView.reloadData()
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
}

// MARK: - DATA
extension CategoryVC {
    private func loadData(with request: NSFetchRequest<CategoryModel> = CategoryModel.fetchRequest()) -> [CategoryModel] {
        do {
            return try coreDataContext.fetch(request)
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func saveData(){
        do{
            try coreDataContext.save()
        }catch{
            print("Error while saving categories: \(error)")
        }
    }
    
    private func addCategory(name: String) -> CategoryModel {
        let newCategory = CategoryModel(context: coreDataContext)
        newCategory.name = name
        saveData()
        return newCategory
    }
}
