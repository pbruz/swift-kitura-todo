//
//  TodosProvider.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import LoggerAPI

class TodosProvider {

    fileprivate lazy var dbTodosProvider = DbTodosProvider()

    func provideList(userId: String, completion: @escaping ([Todo]?, Error?) -> Void) {
        dbTodosProvider.provideList(userId: userId) { json, error in
            if let error = error {
                Log.error(error.localizedDescription)
                completion(nil, error)
                return
            } else if let json = json {
                do {
                    let todos = try TodoMapper().mapToTodoList(json: json)
                    completion(todos, nil)
                } catch let error {
                    Log.error(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
}
