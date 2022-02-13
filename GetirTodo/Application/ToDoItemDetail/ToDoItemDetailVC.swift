//
//  ToDoItemDetailVC.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import UIKit

final class ToDoItemDetailVC: UIViewController {

    private let viewModel: ToDoItemDetailVM
    
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.text = viewModel.getTitle()
            titleTextField.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var detailTextView: UITextView! {
        didSet {
            detailTextView.text = viewModel.getDetail()
        }
    }
    
    init(item: ToDoListItem? = nil) {
        self.viewModel = ToDoItemDetailVM(item: item)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTaskButtonTapped))
        rightBarButtonItem.tintColor = .systemRed
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTaskButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
        
    @objc func deleteTaskButtonTapped() {
        viewModel.deleteItem()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTaskButtonTapped() {
        viewModel.updateItemIfNotEmpty(title: titleTextField.text ?? "", detail: detailTextView.text ?? "")
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- TextField Delegate
extension ToDoItemDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        detailTextView.becomeFirstResponder()
    }
}
