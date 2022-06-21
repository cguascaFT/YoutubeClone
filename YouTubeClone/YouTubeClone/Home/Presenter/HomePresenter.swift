//
//  HomePresenter.swift
//  YouTubeClone
//
//  Created by Cesar Guasca on 18/06/22.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func getData(list: [[Any]])
}

class HomePresenter {
    var provider: HomeProviderProtocol
    weak var delegate: HomeViewProtocol?
    private var objectList:  [[Any]] = []
    
    init(delegate:HomeViewProtocol, provider: HomeProviderProtocol = HomeProvider()){
        self.provider = provider
        self.delegate = delegate
    }
    
    func getHomeObjects() async {
        objectList.removeAll()
        do {
//            let channel = try await provider.getChannel(channelID: Constants.channelID).items
//            let playlist = try await provider.getPlaylists(channelID: Constants.channelID).items
            let videos = try await provider.getVideos(searchString: "", channelID: Constants.channelID).items
//            let playlistItems = try await provider.getPlaylistsItems(playlistId: playlist.first?.id ?? "0").items
//            objectList.append(channel)
//            objectList.append(playlistItems)
            objectList.append(videos)
//            objectList.append(playlist)
            delegate?.getData(list: objectList)
            
        } catch {
            print(error)
        }
    }
}
