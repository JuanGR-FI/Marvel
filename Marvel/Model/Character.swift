//
//  Character.swift
//  Marvel
//
//  Created by Juan Andrés Cervantes Guati Rojo on 06/10/23.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let thumbnail: Image
    let urls: [UrlWebsite]
    let comics: ResourceList<ComicItem>
    let series: ResourceList<SerieItem>
    let stories: ResourceList<StoryItem>
    let events: ResourceList<EventItem>
}
