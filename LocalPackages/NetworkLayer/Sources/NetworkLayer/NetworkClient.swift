//
//  NetworkClient.swift
//  
//
//  Created by Damir Yackupov on 05.09.2022.
//

import Foundation

public protocol NetworkClient {
    func perform<T: Decodable>(request: URLRequest) async throws -> T
}
