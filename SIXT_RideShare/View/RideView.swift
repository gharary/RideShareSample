//
//  RideView.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/16/21.
//

import UIKit
import MapKit
import Kingfisher
import Alamofire
import NVActivityIndicatorView
class RideView: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet private weak var mapView:MKMapView!
    @IBOutlet private weak var tableView:UITableView!
    @IBOutlet private weak var activity:NVActivityIndicatorView!
    
    //MARK: - Properties
    /// `Identifier` for the table view cells
    let cellIdentifier = "RideCell"
    
    /// Array to keep list of annotations
    
    
    
    /// array to keep list of annotation to show on map
    private var displayedAnnotations: [CustomAnnotation]? {
        willSet {
            if let currentAnnotations = displayedAnnotations {
                mapView.removeAnnotations(currentAnnotations)
            }
        }
        didSet {
            if let newAnnotations = displayedAnnotations {
                mapView.addAnnotations(newAnnotations)
            }
            centerMapOnRides()
        }
        
    }
    
    
    /// array of rides to show in `TableView`
    var rides:[RideModel] = [] {
        didSet {
            tableView.reloadData()
            activity.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activity.color = .red
        activity.type = .ballRotateChase
        activity.startAnimating()
        
        
        configMapView()
        
        registerMapAnnotationViews()
        
        
        
        
    }
    
    @IBAction func retryCall(_ sender: UIBarButtonItem) {
        callAPI()
    }
    
    /// here before view loads, we request the server to get data
    override func viewWillAppear(_ animated: Bool) {
        callAPI()
    }
    
    private func callAPI() {
        RideAPI.sharedInstance.getData(completion:{[self] rides,error in
            guard rides.count > 0, error.isEmpty else {
                self.alertUser(sender: self, error)
                return
            }
            self.rides = rides
            displayedAnnotations = extractAnnotations.sharedInstance.configAnnotations(rides: rides)
            
            
        })
    }
    
    
    /// Register the annotation views with the `mapView` so the system can create and efficently reuse the annotation views.
    /// - Tag: RegisterAnnotationViews
    private func registerMapAnnotationViews() {
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self))
        
    }
    
    /// focus the center of the map to the first item of `Rides` received from server
    private func centerMapOnRides() {
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let center = CLLocationCoordinate2D(latitude: rides.first!.lat, longitude: rides.first!.long)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }
    
    
    /// Basic configuration of the `MapView`
    private func configMapView() {
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        
    }

    /// segue to detail view of tableView for selected row
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRideDetail" ,
           let vc = segue.destination as? TableDetailView {
            if let indexPath = tableView.indexPathForSelectedRow {
            
                vc.ride = rides[indexPath.row]
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}



