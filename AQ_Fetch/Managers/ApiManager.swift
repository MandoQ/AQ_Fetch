//
//  ApiRequest.swift
//  AQ_Fetch
//
//  Created by Mando Quintana on 6/23/21.
//

import Foundation

class ApiManager {
    private let url: String
    private let client_id: String
    
    init(endpoint: String) {
        let resourceEndpointString = "https://api.seatgeek.com/2\(endpoint)"
        self.url = resourceEndpointString
        self.client_id = "MjIzMzQ2MTZ8MTYyNDQ3OTI4My4wNjM1NDM2"
    }
    
    func fetchEvents(query: String) -> [Event]? {
        var urlRequest = URLComponents(string: url)!

        urlRequest.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "per_page", value: "25"),
            URLQueryItem(name: "client_id", value: client_id)
        ]
        
        guard let eventsUrl = urlRequest.url else { return nil }
        
        do {
            let data = try Data(contentsOf: eventsUrl)
            let jsonData = try JSONDecoder().decode(Events.self, from: data)
            return jsonData.events
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
