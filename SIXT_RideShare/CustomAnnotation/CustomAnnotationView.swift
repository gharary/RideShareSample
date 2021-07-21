//
//  CustomAnnotationView.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/17/21.
//

import UIKit
import MapKit


class CustomAnnotationView: MKAnnotationView {
    

    /// Custom annotationView for the annotations on the map
    private lazy var label:UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.tintColor = .black
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    override init(annotation:MKAnnotation?, reuseIdentifier:String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.canShowCallout = true
        self.addSubview(stackView)
        
        
    }
    
    override var image:UIImage? {
        get {
            return self.imageView.image
        }
        
        set {
            self.imageView.image = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        /*
         If using the same annotation view and reuse identifier for multiple annotations, iOS will reuse this view by calling `prepareForReuse()`
         so the view can be put into a known default state, and `prepareForDisplay()` right before the annotation view is displayed. This method is
         the view's oppurtunity to update itself to display content for the new annotation.
         */
        if let annotation = annotation as? CustomAnnotation {
            label.text = annotation.title
            imageView.image = annotation.imageName
            
        }
        
        // Since the image and text sizes may have changed, require the system do a layout pass to update the size of the subviews.
        setNeedsLayout()
    }
    
    
    
}
