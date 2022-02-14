//
//  ToDoItemListVM.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation

final class ToDoItemListVM {
    var toDoItemList: [ToDoListItem] = []
        
    func getItems() {
        toDoItemList = RealmManager.shared.getAll(type: ToDoListItem.self)
            .sorted(byKeyPath: "lastUpdateDate", ascending: false)
            .toArray(ofType: ToDoListItem.self)
    }
    
    func deleteItem(index: Int, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        RealmManager.shared.deleteObject(object: toDoItemList[index]) {
            successHandler()
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    func updateItemStatus(index: Int, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        RealmManager.shared.updateObject { [weak self] in
            guard let self = self else { return }
            let currentStatus = self.toDoItemList[index].isDone
            self.toDoItemList[index].isDone = !currentStatus
        } successHandler: {
            successHandler()
        } errorHandler: { error in
            errorHandler(error)
        }
    }
}

