//
//  Cities.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import CoreLocation

enum Cities {
	case moscow
}

extension Cities {
	var coordinates: CLLocationCoordinate2D {
		switch self {
		case .moscow:
			return CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
		}
	}
}
