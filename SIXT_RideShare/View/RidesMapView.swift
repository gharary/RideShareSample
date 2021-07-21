//
//  RidesMapView.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/18/21.
//

import UIKit
import MapKit

extension RideView:MKMapViewDelegate {
    
    
    
    /// making the annotation for the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // As apple suggested, making a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        
        var annotationView:MKAnnotationView?
        
        if let annotation = annotation as? CustomAnnotation {
            annotationView = setupCustomAnnotationView(for: annotation, on: mapView)
            
            let offset = CGPoint(x: annotation.imageName!.size.width / 2, y: -(annotation.imageName!.size.height / 2) )
            annotationView?.centerOffset = offset
        }
        
        return annotationView
    }
    
    
    /// Setup annotation based on the CustomAnnotation
    private func setupCustomAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        
        // this is our unique identifier for view reuse
        let reuseIdentifier = NSStringFromClass(CustomAnnotation.self)
        
        // attemp to find a cell we can recycle
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            // we didn't find one; make a new one
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            // allow this to show pop up information
            annotationView?.canShowCallout = true
        
            
        } else {
            // we have a view to reuse, so give it a new annotation
            annotationView?.annotation = annotation
        }
        
        return annotationView!
        
    }
    
}
extension UIViewController {
    
    open func alertUser(sender: UIViewController,_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
}
