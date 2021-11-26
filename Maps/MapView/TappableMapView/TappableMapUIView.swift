//
//  TappableMapUIView.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import MapKit
import SwiftUI

final class TappableMapUIView: MKMapView {
    var onLongPress: (CLLocationCoordinate2D) -> Void = { _ in }

    init() {
        super.init(frame: .zero)
        let gestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleTap(sender:))
        )
        gestureRecognizer.minimumPressDuration = 0.8
        addGestureRecognizer(gestureRecognizer)
    }

    @objc func handleTap(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let location = sender.location(in: self)
            let coordinate = convert(location, toCoordinateFrom: self)
            onLongPress(coordinate)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
