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
    @Persisted var title: String = "" {
        didSet {
            lastUpdateDate = Date()
        }
    }
    @Persisted var detail: String = "" {
        didSet {
            lastUpdateDate = Date()
        }
    }
    @Persisted var isDone: Bool = false
    @Persisted var lastUpdateDate: Date = Date()
}

