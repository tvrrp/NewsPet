//
//  NetworkError.swift
//  
//
//  Created by Damir Yackupov on 05.09.2022.
//

import Foundation

public enum NetworkError: Swift.Error {
    case invalidStatusCode(_ statusCode: Int)
    case emptyData
    case decoding(_ error: Error)
    case unknown(_ error: Error)
}
