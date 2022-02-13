//
//  ToDoItemDetailVM.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation

final class ToDoItemDetailVM {
    private let toDoListItem: ToDoListItem
    
    init(item: ToDoListItem?) {
        if let item = item {
            self.toDoListItem = item
        } else {
            self.toDoListItem = ToDoListItem()
            RealmManager.shared.addObject(object: toDoListItem) {
                print("ADDED")
            } errorHandler: { error in
                print(error)
            }

        }
    }
    
    func getTitle() -> String {
        return toDoListItem.title
    }
    
    func getDetail() -> String {
        return toDoListItem.detail
    }
        
    func updateTodoItem(title: String?, detail: String?) {
        RealmManager.shared.updateObject {
            if let title = title {
                toDoListItem.title = title
            }
            
            if let detail = detail {
                toDoListItem.detail = detail
            }
        } successHandler: {
            print("UPDATED")
        } errorHandler: { error in
            print(error)
        }
    }
    
    func deleteItem() {
        RealmManager.shared.deleteObject(object: toDoListItem)
    }    
}
