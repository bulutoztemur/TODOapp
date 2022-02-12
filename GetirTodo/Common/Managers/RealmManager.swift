//
//  RealmManager.swift
//  GetirTodo
//
//  Created by alaattinbulut on 12.02.2022.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    private let realm: Realm
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAll<T: Object>(type: T.Type, successHandler: () -> Void) -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func addObject<T: Object>(object: T, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        do {
            try realm.write {
                realm.add(object)
                successHandler()
            }
        } catch {
            errorHandler(error)
        }
    }
    
    func updateObject(updateHandler: () -> Void, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        do {
            try realm.write {
                updateHandler()
                successHandler()
            }
        } catch {
            errorHandler(error)
        }
    }
    
    func deleteObject<T: Object>(object: T, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        do {
            try realm.write {
                realm.delete(object)
                successHandler()
            }
        } catch {
            errorHandler(error)
        }
    }
    
    func printAll<T: Object>(type: T.Type) {
        print(realm.objects(T.self))
    }
}


