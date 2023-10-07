//
//  DataResponse.swift
//  Marvel
//
//  Created by Juan Andrés Cervantes Guati Rojo on 06/10/23.
//

import Foundation

struct DataResponse<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
