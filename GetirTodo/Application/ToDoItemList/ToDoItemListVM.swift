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
    
    private func deleteEmptyItems() {
        RealmManager.shared.getAll(type: ToDoListItem.self)
            .filter { $0.title == "" && $0.detail == "" }
            .forEach {
                RealmManager.shared.deleteObject(object: $0)
            }
    }
}
