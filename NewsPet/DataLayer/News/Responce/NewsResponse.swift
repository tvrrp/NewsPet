//
//  NewsResponse.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

struct NewsResponse: Decodable {
    let id: Int
    let title: String
    let body: String?
}
