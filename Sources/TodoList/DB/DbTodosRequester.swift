//
//  DbTodosRequester.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 21/01/2017.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import SwiftyJSON
import LoggerAPI

class DbTodosRequester {

    func add(todo: Todo, userId: String, completion: @escaping (Error?) -> Void) {
        let todos = Todos()

        let connection = ConnectionFactory.shared.createConnection()

        defer { connection.closeConnection() }
        connection.connect() { error in
            if let error = error {
                Log.error(error.localizedDescription)
                completion(error)
                return
            } else {

                let query = Insert(into: todos, valueTuples: (todos.title, todo.title), (todos.userId, userId))

                connection.execute(query: query) { result in

                    if let error = result.asError {
                        Log.error(error.localizedDescription)
                    }

                    completion(result.success ? nil : result.asError)
                }
            }
        }
    }

    func update(todo: Todo, userId: String, completion: @escaping (Error?) -> Void) {
        let todos = Todos()

        let connection = ConnectionFactory.shared.createConnection()

        defer { connection.closeConnection() }
        connection.connect() { error in
            if let error = error {
                Log.error(error.localizedDescription)
                completion(error)
                return
            } else {

                let query = Update(todos, set: [(todos.title, todo.title)], where: todos.id == todo.id && todos.userId == userId)

                connection.execute(query: query) { result in

                    if let error = result.asError {
                        Log.error(error.localizedDescription)
                    }

                    completion(result.success ? nil : result.asError)
                }
            }
        }
    }

    func delete(id: String, userId: String, completion: @escaping (Error?) -> Void) {
        let todos = Todos()

        let connection = ConnectionFactory.shared.createConnection()

        defer { connection.closeConnection() }
        connection.connect() { error in
            if let error = error {
                Log.error(error.localizedDescription)
                completion(error)
                return
            } else {

                let query = Delete(from: todos, where: todos.id == id && todos.userId == userId)

                connection.execute(query: query) { result in

                    if let error = result.asError {
                        Log.error(error.localizedDescription)
                    }

                    completion(result.success ? nil : result.asError)
                }
            }
        }
    }
}
