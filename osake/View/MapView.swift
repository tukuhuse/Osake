//
//  MapView.swift
//  osake
//
//  Created by 高橋優人 on 2021/07/11.
//

import SwiftUI
import CoreData
import MapKit
import CoreLocation

struct StoreMap: View {
    
    @ObservedObject var store: Store
    @State var manager = CLLocationManager()
    @State var alert = false
    
    var body: some View {
        MapView(store: store,manager: $manager, alert: $alert).alert(isPresented: $alert, content: {
            Alert(title: Text("位置情報取得の許可をお願いします"))
        })
    }
    
}

struct MapView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @ObservedObject var store: Store
    @Binding var manager: CLLocationManager
    @Binding var alert: Bool
    
    let map = MKMapView()
    
    func makeCoordinator() -> MapView.Coordinator {
        
        return MapView.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let center = CLLocationCoordinate2D(latitude: self.store.latitude, longitude: self.store.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.region = region
        
        let point = MKPointAnnotation()
        point.title = self.store.name
        point.subtitle = self.store.name
        point.coordinate.latitude = self.store.latitude
        point.coordinate.longitude = self.store.longitude
        
        map.addAnnotation(point)
        
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        let coordinate = CLLocationCoordinate2D(latitude: self.store.latitude, longitude: self.store.longitude)
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
            let georeader = CLGeocoder()
            
            georeader.reverseGeocodeLocation(location!) { (places, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                /*
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 100000)
                self.parent.map.region = region
                */
            }
        }
        
    }
    
}

struct StoreMap_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let viewContext = PersistenceController.shared.container.viewContext
        let newStore = Store(context: viewContext)
        
        newStore.name = "千秋"
        newStore.latitude = 35.6804
        newStore.longitude = 139.7690
        
        return StoreMap(store: newStore)
            .environment(\.managedObjectContext, viewContext)
    }
}
