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
                print("\(Constants.Strings.addedSuccessfully): \(error.localizedDescription)")
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
    
    func checkAndUpdateItem(title: String, detail: String) {
        if IsItemChanged(title, detail) {
            if isItemEmpty(title, detail) {
                deleteItem()
            } else {
                updateItem(title, detail)
            }
        }
    }
    
    private func IsItemChanged(_ title: String, _ detail: String) -> Bool {
        return initialTitle != title || inititalDetail != detail
    }

    private func isItemEmpty(_ title: String, _ detail: String) -> Bool {
        return title == "" && detail == ""
    }
    
    func deleteItem() {
        RealmManager.shared.deleteObject(object: toDoListItem) {
            print("\(Constants.Strings.deletedSuccessfully)")
        } errorHandler: { error in
            print("\(Constants.Strings.deleteFailed): \(error.localizedDescription)")
        }
    }
        
    private func updateItem(_ title: String, _ detail: String) {
        RealmManager.shared.updateObject {
            toDoListItem.title = title
            toDoListItem.detail = detail
        } successHandler: {
            print("\(Constants.Strings.updatedSuccessfully)")
        } errorHandler: { error in
            print("\(Constants.Strings.updateFailed): \(error.localizedDescription)")
        }
    }
}
