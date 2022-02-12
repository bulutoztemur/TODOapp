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
        removeEmptyItems()
    }
    
    func getItems(success: () -> Void) {
        toDoItemList = RealmManager.shared.getAll(type: ToDoListItem.self)
        success()
    }
    
    private func removeEmptyItems() {
        RealmManager.shared.getAll(type: ToDoListItem.self)
            .filter { $0.title == "" && $0.detail == "" }
            .forEach {
                RealmManager.shared.deleteObject(object: $0)
            }
    }
}
