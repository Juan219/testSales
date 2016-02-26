//
//  StoreAnnotation.swift
//  testSales
//
//  Created by MCS on 12/2/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit
import MapKit

class StoreAnnotation:NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String! = String()
    var subtitle: String! = String()
    var storeImage = UIImageView()
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String)
    {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.storeImage.image = UIImage(named: "facebookIcon")
        
        super.init()
    }
    
    func annotationView() -> MKAnnotationView
    {
        let annotation = MKAnnotationView(annotation: self, reuseIdentifier: "StoreAnnotation")
        
        annotation.canShowCallout = true
        annotation.enabled = true
        annotation.rightCalloutAccessoryView = UIButton(type: .InfoLight)
        
        return annotation
        
    }

}
