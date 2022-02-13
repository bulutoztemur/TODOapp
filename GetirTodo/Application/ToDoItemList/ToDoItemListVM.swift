//
//  ToDoItemListVM.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation

final class ToDoItemListVM {
    var toDoItemList: [ToDoListItem] = []
    
    init() {
        deleteEmptyItems()
    }
    
    func getItems() {
        toDoItemList = RealmManager.shared.getAll(type: ToDoListItem.self)
    }
    
    func deleteItem(index: Int) {
        RealmManager.shared.deleteObject(object: toDoItemList[index])
    }
    
    func updateItemStatus(index: Int) {
        RealmManager.shared.updateObject { [weak self] in
            guard let self = self else { return }
            let currentStatus = self.toDoItemList[index].isDone
            self.toDoItemList[index].isDone = !currentStatus
        } successHandler: {
            print("Status Updated")
        } errorHandler: { error in
            print(error.localizedDescription)
        }

    }
    
    private func deleteEmptyItems() {
        RealmManager.shared.getAll(type: ToDoListItem.self)
            .filter { $0.title == "" && $0.detail == "" }
            .forEach {
                RealmManager.shared.deleteObject(object: $0)
            }
    }
}
