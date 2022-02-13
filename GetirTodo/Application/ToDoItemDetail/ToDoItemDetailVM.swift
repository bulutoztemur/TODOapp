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
                print("ADDED")
            } errorHandler: { error in
                print(error)
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
            print("DELETED")
        } errorHandler: { error in
            print("DELETE ERROR: \(error.localizedDescription)")
        }
    }
        
    private func updateItem(_ title: String, _ detail: String) {
        RealmManager.shared.updateObject {
            toDoListItem.title = title
            toDoListItem.detail = detail
        } successHandler: {
            print("UPDATED")
        } errorHandler: { error in
            print("UPDATE ERROR: \(error.localizedDescription)")
        }
    }
}
