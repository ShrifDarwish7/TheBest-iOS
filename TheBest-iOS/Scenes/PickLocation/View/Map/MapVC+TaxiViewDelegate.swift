//
//  MapVC+TaxiViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 08/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

extension MapVC: TaxiOrderViewDelegate{
    func didCompleteWithAddressFromGoogleMaps(_ address: GoogleMapsGeocodeAddress) {
        loadingView.isHidden = true
        addressLbl.text = address.formattedAddress
        selectedGoogleMapsAddress = address
    }
}
