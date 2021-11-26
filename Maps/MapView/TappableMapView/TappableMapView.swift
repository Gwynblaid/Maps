//
//  TappableMapView.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import MapKit
import SwiftUI
import Combine

struct TappableMapView: UIViewRepresentable {
    @Binding private var annotations: [CLLocationCoordinate2D]
    private let onLongPress: (CLLocationCoordinate2D) -> Void
    let defaultColor: Color
    let selectedColor: Color
    @Binding var selectedLocation: CLLocationCoordinate2D?
    
    // TODO: Добавить в инициализатор начальные координаты
    init(
        annotations: Binding<[CLLocationCoordinate2D]>,
        defaultColor: Color = .blue,
        selectedColor: Color = .green,
        selectedLocation: Binding<CLLocationCoordinate2D?>,
        onLongPress: @escaping (CLLocationCoordinate2D) -> Void
    ) {
        _annotations = annotations
        self.onLongPress = onLongPress
        self.defaultColor = defaultColor
        self.selectedColor = selectedColor
        _selectedLocation = selectedLocation
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = TappableMapUIView()
        // TODO: Убрать хардкод и передавать из вне
        mapView.region = .init(
            center: Cities.moscow.coordinates,
            span: .init(
                latitudeDelta: 0.3,
                longitudeDelta: 0.3
            )
        )
        mapView.delegate = context.coordinator
        mapView.onLongPress = onLongPress
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations.map{
            let annotation = MKPointAnnotation()
            annotation.coordinate = $0
            return annotation
        })
    }
}
extension TappableMapView {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: TappableMapView
        var cancellables = Set<AnyCancellable>()

        init(_ parent: TappableMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard ((annotation as? MKPointAnnotation) != nil) else {
                return nil
            }
            let pinReusable = "pinReusable"
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: pinReusable)
            let color = parent.selectedLocation == annotation.coordinate ? parent.selectedColor : parent.defaultColor
            view.markerTintColor = UIColor(color)
            return view
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let view = view as? MKMarkerAnnotationView,
            let annotation = view.annotation as? MKPointAnnotation else {
                return
            }
            parent.selectedLocation = annotation.coordinate
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
