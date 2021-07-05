//
//  ViewController.swift
//  AQ_Fetch
//
//  Created by Mando Quintana on 6/23/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
  
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchResultsLabel: UILabel!
    
    var results = [Event]()
    var resultsFound = false
    let eventsApiCall = ApiManager(endpoint: "/events")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultsTableView.delegate = self
        self.resultsTableView.dataSource = self
        self.searchBar.delegate = self
        self.resultsTableView.isHidden = true
        resultsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resultsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results.isEmpty && resultsFound {
            searchResultsLabel.text = "No Events Found"
        }else{
            searchResultsLabel.text = "Search For Events"
        }
        
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        
        if eventsCoreDataManager.isFavorite(iD: results[indexPath.row].id) {
            cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        cell.titleLabel.text = results[indexPath.row].short_title
        cell.localDateLabel.text = results[indexPath.row].getFormattedDate()
        cell.stateLabel.text = results[indexPath.row].venue.display_location
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userQuery = searchBar.text else { return }
        
        if !userQuery.isEmpty {
            guard let fetchedEvents = eventsApiCall.fetchEvents(query: userQuery) else { return }
            results = fetchedEvents
            resultsFound = true
        }else{
            results = []
            resultsFound = false
        }
        
        view.endEditing(true)
        toggleTableView()
        resultsTableView.reloadData()
    }
    
    func toggleTableView(){
        if !results.isEmpty && resultsFound {
            searchResultsLabel.isHidden = true
            resultsTableView.isHidden = false
        }else{
            searchResultsLabel.isHidden = false
            resultsTableView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "EventDetailsStaticTableViewController", sender: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventDetailsStaticTableViewController" {
            guard let indexPath = self.resultsTableView.indexPathForSelectedRow else { return }
            let selectedEvent = results[indexPath.row]
            let view = segue.destination as! EventDetailsStaticTableViewController
            
            view.event = selectedEvent
            view.isFavorite = eventsCoreDataManager.isFavorite(iD: results[indexPath.row].id)
        }
    }
}
