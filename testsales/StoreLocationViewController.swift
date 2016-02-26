//
//  StoreLocationViewController.swift
//  testSales
//
//  Created by MCS on 11/16/15.
//  Copyright © 2015 balderas.juan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreLocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,RequesterHelperDelegate, CLLocationManagerDelegate,MKMapViewDelegate {
    var show : Bool = Bool()
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var storeListTableView: UITableView! = UITableView()
    @IBOutlet var storeListMapView: MKMapView! = MKMapView()
    
    let requester = RequesterHelper.sharedInstance
    
    var Stores  = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        createMapview()
        
        requester.delegate = self
        requester.loadStores()
        
        checkForLocationPermit()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMapview()
    {
        storeListMapView.frame.size = CGSizeMake(storeListTableView.frame.width, storeListTableView.frame.height)
        self.storeListMapView.delegate = self
        self.view.addSubview(storeListMapView)
    }
    
    @IBAction func changeViewPerpective(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0
        {
            storeListMapView.hidden = false
            self.view.bringSubviewToFront(storeListMapView)
            
        }
        else
        {
            storeListMapView.hidden = true
            storeListTableView.hidden = false
            self.view.bringSubviewToFront(storeListTableView)
        }
    }
    
    // MARK: - TableViewtDelegateMethods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Stores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        cell.textLabel?.text = Stores[indexPath.row].name
        cell.detailTextLabel?.text = "\(Stores[indexPath.row].identifier)"
        
        return cell
    }
    
    // MARK: - RequestDelegateMethods
    
    func requester(requester: RequesterHelper, didFindStore store: Store) {
        Stores.append(store)
        storeListTableView.reloadData()
    }

    
    //MARK: - MapKitMethods
    
    
    
    var locationManager : CLLocationManager?
    
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        print("load code")
    }
    
    func searchForStore(storeName:String, map : MKMapView)
    {
        let request  = MKLocalSearchRequest()
        
        
        request.naturalLanguageQuery = storeName
        //let span = MKCoordinateSpanMake(0.001, 0.001)
        let region  = MKCoordinateRegionMakeWithDistance((map.userLocation.location?.coordinate)!, 1000, 1000)
        request.region = region
        //request.region.span = span
        
        let search = MKLocalSearch(request: request)
        
        
        search.startWithCompletionHandler({(response : MKLocalSearchResponse?,error : NSError?) -> ()in
            
            if error != nil
            {
                print("Error ocurred in search : \(error?.localizedDescription)")
            }
            else if response?.mapItems.count == 0
            {
                print("No matches found")
            }
            else
            {
                var storess : [MKMapItem] = [MKMapItem]()
                print("\(response?.mapItems.count) Matches Found")
                
                if response?.mapItems.count == 2
                {
                    print("")
                }
                else if response?.mapItems.count > 5
                {
                    var range = NSRange()
                    range.location = 5
                    range.length = (response?.mapItems.count)! - 1
                    
                    
                    storess = (response?.mapItems)!
                    let i : Int = (response?.mapItems.count)! - 1
                    storess.removeRange(1..<i)
                    
                }

                for item in storess as [MKMapItem]!
                {

                    let location = CLLocationCoordinate2D(latitude: (item.placemark.location?.coordinate.latitude)! , longitude: (item.placemark.location?.coordinate.longitude)!)

                    if item.phoneNumber != nil
                    {
                        
                        let annotation = StoreAnnotation(coordinate: location, title: item.name! ,subtitle: item.phoneNumber!)
                        
                        annotation.annotationView()
                        
                        
                        self.storeListMapView.addAnnotation(annotation)
                    }
                    

                }
                
            }
        })
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("The authorization status of location services is changed to: ")
        
        switch CLLocationManager.authorizationStatus(){
                    
        case .Authorized:
            print("Authorized")
        case .AuthorizedWhenInUse:
            print("Authorized when in use")
        case .Denied:
            print("Denied")
        case .NotDetermined:
            print("Not determined")
        case .Restricted:
                print("Restricted")
        default:
                print("Unhandled")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print("Location manager failed with error = \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    
            let location = newLocation
                    
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    
            self.storeListMapView.setRegion(region, animated: true)
                        
            self.storeListMapView.showsUserLocation = true
        
    }

    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager) {
            }
    
    
    @IBAction func update(sender: AnyObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0),{
            for storeInList in self.Stores
            {
                dispatch_sync(dispatch_get_main_queue(), {
                    self.searchForStore(storeInList.name, map: self.storeListMapView)
                })
                
            }
            self.locationManager?.stopUpdatingLocation()
        })
    }
    
    func showMyLocation()
    {
        
    }
    func showStores()
    {
        
    }
    
    func checkForLocationPermit()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus()
            {
            case .Authorized:
                /* Yes, always. */
                createLocationManager(true)
            case .AuthorizedWhenInUse:
                /* Yes, only when our app is in use. */
                createLocationManager(true)
            case .Denied:
                /* No. */
                print("Denied")
            case .NotDetermined:
                /* We don't know yet; we have to ask */
                createLocationManager(false)
                if let manager = self.locationManager
                {
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                print("Restricted")
            }
        }
        else{
            print("Location services are not enabled")
        }
    }
    
    func createLocationManager(startImmediately: Bool)
            {
                locationManager = CLLocationManager()
                if let manager = locationManager
                {
                    print("Successfully created the location manager")
                    manager.delegate = self
                    if startImmediately
                    {
                        manager.startUpdatingLocation()
                    }
                }
            }
    
    
}
