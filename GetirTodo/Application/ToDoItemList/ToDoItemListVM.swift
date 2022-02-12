//
//  ToDoItemListVM.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation

final class ToDoItemListVM {
    var toDoItemList: [ToDoListItem] = []
    
    func getItems(success: () -> Void) {
        toDoItemList = RealmManager.shared.getAll(type: ToDoListItem.self)
        success()
    }
}
