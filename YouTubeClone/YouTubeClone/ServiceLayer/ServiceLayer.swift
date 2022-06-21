//
//  ServiceLayer.swift
//  YouTubeClone
//
//  Created by Cesar Guasca on 18/06/22.
//

import Foundation
import UIKit

@MainActor
class ServiceLayer {
    static func callService<T:Decodable>(_ requestModel: RequestModel, modelType: T.Type) async throws -> T {
        var serviceURL = URLComponents(string: requestModel.getURL())
        serviceURL?.queryItems = buildQueryItems(params:requestModel.queryItems ?? [:])
        serviceURL?.queryItems?.append(URLQueryItem(name: "key", value: Constants.apiKey))
        
        guard let componentURL = serviceURL?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: componentURL)
        request.httpMethod = requestModel.httpMethod.rawValue
        request.addValue("Bearer \(Constants.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.httpResponseError
            }
            
            if(httpResponse.statusCode > 299) {
                throw NetworkError.statusCodeError
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodeData = try decoder.decode(T.self, from: data)
                return decodeData
            } catch {
                throw NetworkError.couldNotDecodeData
            }
            
        } catch {
            print(error)
            throw NetworkError.generic
        }
    }
    
    static func buildQueryItems(params: [String:String]) -> [URLQueryItem] {
        let items = params.map({URLQueryItem(name: $0, value: $1)})
        return items
    }
}
