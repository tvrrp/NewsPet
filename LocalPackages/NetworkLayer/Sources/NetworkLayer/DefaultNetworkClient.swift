//
//  DefaultNetworkClient.swift
//
//
//  Created by Damir Yackupov on 05.09.2022.
//

import Foundation

public final class DefaultNetworkClient: NetworkClient {
    private static let decoder = JSONDecoder()
    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func perform<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, response, error) = try await urlSession.data(for: request)
        if let error = error {
            throw(NetworkError.unknown(error))
        }
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
            throw(NetworkError.invalidStatusCode(response.statusCode))
        }
        guard let data = data else {
            throw(NetworkError.emptyData)
        }
        do {
            let result = try Self.decoder.decode(T.self, from: data)
            return result
        } catch {
            throw (NetworkError.decoding(error))
        }
    }
}

// swiftlint:disable large_tuple
extension URLSession {
    @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
    func data(for request: URLRequest) async throws -> (Data?, URLResponse?, Error?) {
        await withCheckedContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                continuation.resume(returning: (data, response, error))
            }

            task.resume()
        }
    }
}
