//
//  Errors.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import Foundation

enum DaoError: Error {
    case notFound, somethingWrong
}

enum RepositoryError: Error {
    case notFound, somethingWentWrong
}
