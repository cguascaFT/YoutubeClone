//
//  Provider.swift
//  YouTubeClone
//
//  Created by Cesar Guasca on 18/06/22.
//

import Foundation

protocol HomeProviderProtocol {
    func getVideos(searchString: String, channelID: String) async throws -> VideoModel
    func getChannel(channelID: String) async throws -> ChannelModel
    func getPlaylists(channelID: String) async throws -> PlayListModel
    func getPlaylistsItems(playlistId: String) async throws -> PlaylistItemsModel
}

class HomeProvider: HomeProviderProtocol {
    func getVideos(searchString: String, channelID: String) async throws -> VideoModel {
        var queryParams: [String: String] = ["part":"snippet"]
        if !channelID.isEmpty {
            queryParams["channelId"] = channelID
        }
        if !searchString.isEmpty {
            queryParams["q"] = searchString
        }
        
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams)
        
        do {
            let model =  try await ServiceLayer.callService(requestModel, modelType: VideoModel.self)
            return model
        } catch {
            print(error)
            throw error
        }
    }
    
    func getChannel(channelID: String) async throws -> ChannelModel {
        let queryParams: [String: String] = ["part":"snippet,stadistics,brandingSettings", "id": channelID]
        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams)
        do {
            let model =  try await ServiceLayer.callService(requestModel, modelType: ChannelModel.self)
            return model
        } catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylists(channelID: String) async throws -> PlayListModel {
        let queryParams: [String: String] = ["part":"snippet,contentDetails", "channelId": channelID]
        let requestModel = RequestModel(endpoint: .playlists, queryItems: queryParams)
        do {
            let model =  try await ServiceLayer.callService(requestModel, modelType: PlayListModel.self)
            return model
        } catch {
            print(error)
            throw error
        }
    }
    
    func getPlaylistsItems(playlistId: String) async throws -> PlaylistItemsModel {
        let queryParams: [String: String] = ["part":"snippet,id,contentDetails", "playListId": playlistId]
        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams)
        do {
            let model =  try await ServiceLayer.callService(requestModel, modelType: PlaylistItemsModel.self)
            return model
        } catch {
            print(error)
            throw error
        }
    }
}
