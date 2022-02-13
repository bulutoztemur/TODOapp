//
//  Results+Extension.swift
//  GetirTodo
//
//  Created by alaattinbulut on 13.02.2022.
//

import RealmSwift

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    return self.compactMap{$0 as? T}
  }
}
