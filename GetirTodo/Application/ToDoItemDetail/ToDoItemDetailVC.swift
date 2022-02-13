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
        }
    }
    
    @IBOutlet weak var detailTextView: UITextView! {
        didSet {
            detailTextView.text = viewModel.getDetail()
        }
    }
    
    @IBOutlet weak var detailTextViewBottomConstraint: NSLayoutConstraint!
    
    init(item: ToDoListItem? = nil) {
        self.viewModel = ToDoItemDetailVM(item: item)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
        configureNavigationBar()
    }
}

//MARK:- Navigation Bar Configuration
private extension ToDoItemDetailVC {
    func configureNavigationBar() {
        createLeftBarButtonItem()
        createRightBarButtonItem()
    }
    
    func createLeftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTaskButtonTapped))
    }
    
    func createRightBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTaskButtonTapped))
        rightBarButtonItem.tintColor = .systemRed
        navigationItem.rightBarButtonItem = rightBarButtonItem
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

//MARK:- Keyboard Observation
private extension ToDoItemDetailVC {
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisapper),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            detailTextViewBottomConstraint.constant = keyboardHeight
        }
    }
    
    @objc func keyboardWillDisapper(_ notification: Notification) {
        detailTextViewBottomConstraint.constant = 0
    }
}
