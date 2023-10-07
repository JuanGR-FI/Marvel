//
//  ResourceList.swift
//  Marvel
//
//  Created by Juan Andrés Cervantes Guati Rojo on 06/10/23.
//

import Foundation

struct ResourceList<T : Codable> : Codable {
    let available: Int
    let collectionURI: String
    let returned: Int
    let items: [T]
}
