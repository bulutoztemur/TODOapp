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
            tasksTableView.register(cellClass: UITableViewCell.self)
        }
    }
    
    @IBOutlet weak var noDataView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTableView()
    }
    
    private func checkNoData() {
        tasksTableView.isHidden = viewModel.toDoItemList.isEmpty
        noDataView.isHidden = !viewModel.toDoItemList.isEmpty
    }
}

//MARK:- Navigation Bar Configuration
private extension ToDoItemListVC {
    func configureNavigationBar() {
        navigationItem.title = Constants.Strings.myTasksTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskButtonTapped))
    }
    
    @objc func addTaskButtonTapped() {
        navigateToDetailScreen()
    }
    
    func navigateToDetailScreen(detailVC: ToDoItemDetailVC = ToDoItemDetailVC()) {
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK:- TableView Operations
extension ToDoItemListVC: UITableViewDelegate, UITableViewDataSource {
    private func refreshTableView() {
        viewModel.getItems()
        checkNoData()
        tasksTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.toDoItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        let toDoListItem = viewModel.toDoItemList[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        cell.textLabel?.text = toDoListItem.title
        cell.imageView?.image = toDoListItem.isDone ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "clock.arrow.circlepath")
        cell.imageView?.tintColor = toDoListItem.isDone ? .systemGreen : .systemOrange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailScreen(detailVC: ToDoItemDetailVC(item: viewModel.toDoItemList[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, _) in
            self?.viewModel.deleteItem(index: indexPath.row)
            self?.refreshTableView()
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let toDoListItem = viewModel.toDoItemList[indexPath.row]
        let changeStatusAction = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, _) in
            self?.viewModel.updateItemStatus(index: indexPath.row)
            self?.refreshTableView()
        }
        changeStatusAction.image = toDoListItem.isDone ? UIImage(systemName: "clock.arrow.circlepath") : UIImage(systemName: "checkmark.circle.fill")
        changeStatusAction.backgroundColor = toDoListItem.isDone ? .systemOrange : .systemGreen
        return UISwipeActionsConfiguration(actions: [changeStatusAction])
    }    
}
