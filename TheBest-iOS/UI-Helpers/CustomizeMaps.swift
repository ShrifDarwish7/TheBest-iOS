//
//  CustomizeMaps.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 11/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMapView{
    func setStyle(){
        do {
            if let styleURL = Bundle.main.url(forResource: "MapSilverStyle", withExtension: "json") {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }
        } catch { }
    }
}
