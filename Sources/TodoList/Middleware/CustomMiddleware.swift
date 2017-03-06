//
//  CustomMiddleware.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 22/11/2016.
//
//

import Foundation
import Kitura

final class CustomMiddleware: RouterMiddleware {

    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        print("Do sth unordinary!")
        next()
    }
}
