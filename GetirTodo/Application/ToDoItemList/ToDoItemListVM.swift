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
    }
    
    func deleteItem(index: Int) {
        RealmManager.shared.deleteObject(object: toDoItemList[index]) {
            print("DELETED")
        } errorHandler: { error in
            print("DELETE ERROR: \(error.localizedDescription)")
        }
    }
    
    func updateItemStatus(index: Int) {
        RealmManager.shared.updateObject { [weak self] in
            guard let self = self else { return }
            let currentStatus = self.toDoItemList[index].isDone
            self.toDoItemList[index].isDone = !currentStatus
        } successHandler: {
            print("STATUS UPDATED")
        } errorHandler: { error in
            print("STATUS UPDATE ERROR: \(error.localizedDescription)")
        }
    }
}
