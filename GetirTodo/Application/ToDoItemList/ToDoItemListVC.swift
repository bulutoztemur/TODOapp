//
//  ToDoItemListVC.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import UIKit

final class ToDoItemListVC: UIViewController {

    private let viewModel = ToDoItemListVM()
    
    @IBOutlet weak var tasksTableView: UITableView! {
        didSet {
            tasksTableView.tableFooterView = UIView(frame: .zero)
            tasksTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskButtonTapped))
        RealmManager.shared.printAll(type: ToDoListItem.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    
    @objc func addTaskButtonTapped() {
        navigateToDetailScreen()
    }
    
    func navigateToDetailScreen(detailVC: ToDoItemDetailVC = ToDoItemDetailVC()) {
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func refreshTableView() {
        viewModel.getItems()
        tasksTableView.reloadData()
    }
}

extension ToDoItemListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.toDoItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.toDoItemList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailScreen(detailVC: ToDoItemDetailVC(item: viewModel.toDoItemList[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, _) in
            self?.viewModel.deleteItem(index: indexPath.row)
            self?.refreshTableView()
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
