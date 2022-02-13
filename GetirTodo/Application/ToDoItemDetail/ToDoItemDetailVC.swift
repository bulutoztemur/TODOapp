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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.deleteItemIfEmpty()
    }
}

//MARK:- TextField Change Listener
extension ToDoItemDetailVC {
    @objc func titleTextFieldDidChange(_ textField: UITextField) {
        viewModel.updateTodoItem(title: textField.text, detail: nil)
    }
}

//MARK:- TextView Change Listener
extension ToDoItemDetailVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.updateTodoItem(title: nil, detail: textView.text)
    }
}

