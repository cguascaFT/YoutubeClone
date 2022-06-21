//
//  RequestModel.swift
//  YouTubeClone
//
//  Created by Cesar Guasca on 18/06/22.
//

import Foundation

struct RequestModel {
    let endpoint: Endpoints
    var queryItems: [String: String]?
    let httpMethod: HttpMethod = .GET
    var baseUrl: URLBase = .youtube
    
    func getURL() -> String {
        return baseUrl.rawValue + endpoint.rawValue
    }
    
    enum HttpMethod: String {
        case GET
        case POST
    }
    
    enum Endpoints: String {
        case search = "search"
        case channels = "channels"
        case playlists = "playlists"
        case playlistItems = "playlistItems"
        case empty = ""
    }
    
    enum URLBase: String {
        case youtube = "https://youtube.googleapis.com/youtube/v3/"
    }
}
