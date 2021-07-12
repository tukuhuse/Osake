//
//  MapView.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/11.
//

import SwiftUI
import MapKit
import CoreLocation

struct StoreMap: View {
    
    @State var manager = CLLocationManager()
    @State var alert = false
    
    var body: some View {
        MapView(manager: $manager, alert: $alert).alert(isPresented: $alert, content: {
            Alert(title: Text("位置情報取得の許可をお願いします"))
        })
    }
    
}

struct MapView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @Binding var manager: CLLocationManager
    @Binding var alert: Bool
    
    let map = MKMapView()
    
    func makeCoordinator() -> MapView.Coordinator {
        
        return MapView.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let center = CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.region = region
        
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let coordinate = CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        uiView.setRegion(region, animated: true)
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate {
        
        var parent : MapView
        
        init(parent1: MapView) {
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied{
                parent.alert.toggle()
                print("denied")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let location = locations.last
            let point = MKPointAnnotation()
            let georeader = CLGeocoder()
            
            georeader.reverseGeocodeLocation(location!) { (places, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current Place"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 100000)
                self.parent.map.region = region
            }
        }
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        StoreMap()
            .preferredColorScheme(.dark)
    }
}