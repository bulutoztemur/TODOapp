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
            titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
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
    }
        
    @objc func deleteTaskButtonTapped() {
        viewModel.deleteItem()
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- TextField Change Listener
extension ToDoItemDetailVC: UITextFieldDelegate {
    @objc func titleTextFieldDidChange(_ textField: UITextField) {
        viewModel.updateTodoItem(title: textField.text, detail: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        detailTextView.becomeFirstResponder()
    }
}

//MARK:- TextView Change Listener
extension ToDoItemDetailVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.updateTodoItem(title: nil, detail: textView.text)
    }
}

