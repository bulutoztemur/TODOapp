//
//  ToDoListItem.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
    @Persisted(primaryKey: true) var primaryKey: UUID = UUID()
    @Persisted var title: String = ""
    @Persisted var detail: String = ""
    @Persisted var lastUpdateDate: Date = Date()
}

