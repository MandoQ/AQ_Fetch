//
//  Events.swift
//  AQ_Fetch
//
//  Created by Mando Quintana on 6/23/21.
//

import Foundation
import UIKit

struct Events: Codable {
    let events: [Event]
}

struct Event: Codable {
    let type: String
    let performers: [Performers]?
    let id: Int
    let title: String?
    let short_title: String?
    let datetime_local: String?
    let venue: Venue
}

struct Performers: Codable {
    let name: String
    let image: String
}

struct Venue: Codable {
    let name: String
    let display_location: String
    let address: String
}

extension Event {
    func getFormattedDate() -> String {
        guard let eventDate = datetime_local else { return "n/a" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let updatedAt = dateFormatter.date(from: eventDate) //
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        let newDateString = newFormatter.string(from: updatedAt!)
        return newDateString
    }
}

//https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
extension UIImageView {
    func loadImage(imageUrl: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageUrl){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
