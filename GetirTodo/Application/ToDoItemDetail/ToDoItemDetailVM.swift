//
//  ToDoItemDetailVM.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation

final class ToDoItemDetailVM {
    private let toDoListItem: ToDoListItem
    private let initialTitle: String
    private let inititalDetail: String
    
    init(item: ToDoListItem?) {
        if let item = item {
            self.toDoListItem = item
            self.initialTitle = item.title
            self.inititalDetail = item.detail
        } else {
            self.toDoListItem = ToDoListItem()
            RealmManager.shared.addObject(object: toDoListItem) {
                print("\(Constants.Strings.addedSuccessfully)")
            } errorHandler: { error in
                print("\(Constants.Strings.addFailed): \(error.localizedDescription)")
            }
            self.initialTitle = ""
            self.inititalDetail = ""
        }
    }
    
    func getTitle() -> String {
        toDoListItem.title
    }
    
    func getDetail() -> String {
        toDoListItem.detail
    }
    
    func checkAndUpdateItem(title: String, detail: String, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        if isItemEmpty(title, detail) {
            deleteItem(successHandler: successHandler, errorHandler: errorHandler)
        } else if IsItemChanged(title, detail) {
            updateItem(title, detail, successHandler: successHandler, errorHandler: errorHandler)
        } else {
            successHandler()
        }
        
    }
    
    private func IsItemChanged(_ title: String, _ detail: String) -> Bool {
        return initialTitle != title || inititalDetail != detail
    }

    private func isItemEmpty(_ title: String, _ detail: String) -> Bool {
        return title == "" && detail == ""
    }
    
    func deleteItem(successHandler: () -> Void, errorHandler: (Error) -> Void) {
        RealmManager.shared.deleteObject(object: toDoListItem) {
            successHandler()
        } errorHandler: { error in
            errorHandler(error)
        }
    }
        
    private func updateItem(_ title: String, _ detail: String, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        RealmManager.shared.updateObject {
            toDoListItem.title = title
            toDoListItem.detail = detail
        } successHandler: {
            successHandler()
        } errorHandler: { error in
            errorHandler(error)
        }
    }
}
