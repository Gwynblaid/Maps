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
    @Binding var selectedLocation: CLLocationCoordinate2D?
    @Binding var location: MKCoordinateRegion
    @PropertyWrapper private var prevLocation: MKCoordinateRegion
    private let onLongPress: (CLLocationCoordinate2D) -> Void
    private let onDeletedMark: (CLLocationCoordinate2D) -> Void
    
    // TODO: Добавить в инициализатор начальные координаты
    init(
        location: Binding<MKCoordinateRegion>,
        annotations: Binding<[CLLocationCoordinate2D]>,
        selectedLocation: Binding<CLLocationCoordinate2D?>,
        onLongPress: @escaping (CLLocationCoordinate2D) -> Void,
        onDeletedMark: @escaping (CLLocationCoordinate2D) -> Void
    ) {
        _location = location
        _annotations = annotations
        _selectedLocation = selectedLocation
        self.prevLocation = location.wrappedValue
        self.onLongPress = onLongPress
        self.onDeletedMark = onDeletedMark
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = TappableMapUIView()
        // TODO: Убрать хардкод и передавать из вне
        mapView.region = location
        mapView.delegate = context.coordinator
        mapView.onLongPress = onLongPress
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // TODO: Добавить плавное изменение аннотаций и оверлея
        // Надо вычислять какой эвент тригернул изменение View
        uiView.removeOverlays(uiView.overlays)
        uiView.addOverlay(MKPolyline(coordinates: annotations, count: annotations.count))
        let addAnnotations = annotations.map(TappableMapAnnotation.init)
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(addAnnotations)

        if prevLocation.center != location.center {
            uiView.region = location
            prevLocation = location
        }
    }
}
extension TappableMapView {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: TappableMapView
        var cancellables = Set<AnyCancellable>()

        init(_ parent: TappableMapView) {
            self.parent = parent
        }

        func mapView(
            _ mapView: MKMapView,
            viewFor annotation: MKAnnotation
        ) -> MKAnnotationView? {
            guard let annotation = annotation as? TappableMapAnnotation else {
              return nil
            }
            let identifier = "TappableMapAnnotation"
            var view: MKMarkerAnnotationView
            let isSelected = annotation.coordinate == parent.selectedLocation
            if let dequeuedView = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                view.isSelected = isSelected
            } else {
                view = MKMarkerAnnotationView(
                    annotation: annotation,
                    reuseIdentifier: identifier
                )
                
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
                button.setImage(UIImage(systemName: "trash"), for: .normal)
                button.addAction(
                    UIAction(handler: { [weak self, annotation] _ in
                        self?.parent.onDeletedMark(annotation.coordinate)
                    }),
                    for: .touchUpInside
                )
                view.rightCalloutAccessoryView = button
                view.isSelected = isSelected
            }
            return view
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let view = view as? MKMarkerAnnotationView,
            let annotation = view.annotation as? TappableMapAnnotation else {
                return
            }
            parent.selectedLocation = annotation.coordinate
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else {
                return MKOverlayRenderer()
            }
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.fillColor = .clear
            renderer.strokeColor = .red
            renderer.lineWidth = 5
            return renderer
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
