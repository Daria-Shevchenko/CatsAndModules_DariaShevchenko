//
//  NetworkError.swift
//  NetworkService
//
//  Created by Daria Shevchenko on 17.06.2022.
//

import Foundation

enum NetworkError: Error {
    case request(requestError: Error)
    case unableToDecode(underlyingError: Error)
}
