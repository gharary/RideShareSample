//
//  ViewModel.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/18/21.
//

import UIKit
import MapKit

public class extractAnnotations {
    
    public static let sharedInstance = extractAnnotations()
    
    private init() { }
    private var allRides:[CustomAnnotation]? = []
    
    
    /// extract annotation from `RideModel`s retreived from server
    func configAnnotations(rides:[RideModel]) -> [CustomAnnotation]{
        
        for item in rides {
            let coordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            let customAnnotation = CustomAnnotation(coordinate: coordinate, title: item.modelName, subtitle: item.name, image: UIImage(systemName: "car.fill")!)
            self.allRides?.append(customAnnotation)

        }
        
        return allRides ?? []
    }
}
