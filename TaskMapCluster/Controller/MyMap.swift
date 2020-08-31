//
//  Map.swift
//  TaskMapCluster
//  Created by MOHANNED on 14/7/20.
//  Copyright © 2019 MOHANNED. All rights reserved.
//
import UIKit
import Alamofire
import GoogleMaps
import GoogleMapsUtils
//import GooglePlaces
//import MapKit

class MyMap: UIViewController, GMUClusterManagerDelegate {
    var lat: Double?
    var lon: Double?
   // let kClusterItemCount = 10000
    let kCameraLatitude = -33.8
    let kCameraLongitude = 151.2
    var Companes = [LocationData]()
    
    @IBOutlet weak var mapView: GMSMapView!
    //  You don't need to modify the default init(nibName:bundle:) method.
    // 1  MARK: INITIALIZE CLUSTER ITEMS
    private var clusterManager: GMUClusterManager!
    func initializeClusterItems() {
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUGridBasedClusterAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        self.clusterManager.cluster()
        self.clusterManager.setDelegate(self, mapDelegate: self)
    }
    override func viewDidLoad() {
        // call api...
        let camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude,
        longitude: kCameraLongitude, zoom: 10)
       // mapView.camera = camera
        mapView.delegate = self
        DispatchQueue.global(qos: .background).async {
            let params = ["apiKey": "501edc9e"]
            APIServiceGeneric.instance.getData(url: "https://myscrap.com/api/msDiscoverPage", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil, viewController: self) { (jsonBase, error) in
              // handle error
                if let error = error {
                    print(error)
                } else {
                    guard let data = jsonBase?.locationData else { return }
                    self.Companes = data
                    print(self.Companes, "Companes")
                    DispatchQueue.main.async {
                        self.initializeClusterItems()
                        self.setMarkerForMap(locations: self.Companes)
                    }
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    //2
    func setMarkerForMap(locations: [LocationData]) -> Void {
        //self.mapView.clear()
        var index = 0
        
        for location in locations {
            let lat: Double = Double(location.latitude ?? "") ?? 0.0
            let lang: Double = Double(location.longitude ?? "") ?? 0.0
            print(lang, lat, "Lat_lang")
            let marker = GMSMarker()
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude:lang)
            marker.position = coordinate
            
            marker.userData = location
            marker.map = mapView
            
            let name = location.name ?? ""
            let item = POIItem(position: CLLocationCoordinate2DMake(lat, lang), name: name)
            clusterManager.add(item)
            index += 1
        }
        self.clusterManager.cluster()
    }
    
    
    func generatePOIItems(_ accessibilityLabel: String, position: CLLocationCoordinate2D, icon: UIImage?) {
        let item = POIItem(position: position, name: accessibilityLabel)
        self.clusterManager.add(item)
    }
}

// new didTap marker - when u tab on marker
extension MyMap: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
      if let poiItem = marker.userData as? POIItem {
        NSLog("Did tap marker for cluster item \(String(describing: poiItem.name))")
        marker.title = poiItem.name
      } else {
        NSLog("Did tap a normal marker")
      }
      return false
    }

  
 // extension MyMap : MKMapViewDelegate {
  func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
    let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
      zoom: mapView.camera.zoom + 1)
    let update = GMSCameraUpdate.setCamera(newCamera)
    mapView.moveCamera(update)
    return false
  }
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let mapBoundsWidth = Double(self.mapView.bounds.size.width)
//        let mapVisibleRect = self.mapView.paddingAdjustmentBehavior
//        let scale = mapBoundsWidth / mapVisibleRect.size.width
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let strongSelf = self else { return }
//            let annotationArray = strongSelf.clusteringManager.clusteredAnnotations(withinMapRect: mapVisibleRect, zoomScale:scale)
//
//            DispatchQueue.main.async { [weak self] in
//                guard let strongSelf = self else { return }
//                strongSelf.clusteringManager.display(annotations: annotationArray, onMapView:strongSelf.mapView)
//            }
//        }
//    }
//}
class POIItem: NSObject, GMUClusterItem {
  var position: CLLocationCoordinate2D
  var name: String!

  init(position: CLLocationCoordinate2D, name: String) {
    self.position = position
    self.name = name
  }
}
}
