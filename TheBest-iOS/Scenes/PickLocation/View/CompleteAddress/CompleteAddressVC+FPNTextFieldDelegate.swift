//
//  CompleteAddressVC+FPNTextFieldDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 09/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import FlagPhoneNumber

extension CompleteAddressVC: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        self.dialCode = dialCode
        self.selectedFPNContryCode = code
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
    }
    
    func fpnDisplayCountryList() {
        
    }
}
