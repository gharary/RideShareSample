//
//  CustomAnnotation.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/16/21.
//

import UIKit
import MapKit

class CustomAnnotation:NSObject, MKAnnotation {
    
    // As `Apple` suggested, this property must be key-value observable, which the `@objc dynamic` attributes provide.
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var title: String?
    
    var subtitle: String?
    
    var imageName:UIImage?
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, image:UIImage) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = image
        super.init()
    }
}
