//
//  EventDetailsStaticTableViewController.swift
//  AQ_Fetch
//
//  Created by Mando Quintana on 7/3/21.
//

import UIKit

class EventDetailsStaticTableViewController: UITableViewController {
    var event: Event!
    
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var venueNameLabel: UILabel!
    @IBOutlet var localDateLabel: UILabel!
    @IBOutlet var venueLocationLabel: UILabel!
    @IBOutlet var venueAddressLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var performerImage: UIImageView!
    
    var isFavorite: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        titleLabel.text = event.title
        typeLabel.text = event.type
        venueNameLabel.text = event.venue.name
        venueAddressLabel.text = event.venue.address
        venueLocationLabel.text = event.venue.display_location
        localDateLabel.text = event.getFormattedDate()
        
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        loadImage()
    }
    
    func loadImage(){
        if let imageStringUrl = event.performers?[0].image {
            if let imageUrl = URL(string: imageStringUrl) {
                performerImage.loadImage(imageUrl: imageUrl)
            }
        }else{
            let placeHolderUrl = URL(string: "https://via.placeholder.com/300x250.png?text=No+Image+Found")
            performerImage.loadImage(imageUrl: placeHolderUrl!)
        }
    }
    
    @IBAction func didPressFavoriteButton(_ sender: Any) {

        let selectedEventId = event.id
        
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            eventsCoreDataManager.deleteEvent(iD: selectedEventId)
        }else{
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            eventsCoreDataManager.saveEvent(eventIdToSave: selectedEventId)
        }
        isFavorite = !isFavorite

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
}
