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
    let onLongPress: (CLLocationCoordinate2D) -> Void
    
    init(
        annotations: Binding<[CLLocationCoordinate2D]>,
        onLongPress: @escaping (CLLocationCoordinate2D) -> Void
    ) {
        _annotations = annotations
        self.onLongPress = onLongPress
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = TappableMapUIView()
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
        init(_ parent: TappableMapView) {
            self.parent = parent
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
