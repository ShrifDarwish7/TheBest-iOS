//
//  FilterVC+MarketsViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension FilterVC: MarketsViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteFiltering(_ result: [Item]) {
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("filter_result"), object: nil, userInfo: ["markets": result])
    }
    
    func didFailFiltering() {
        showAlert(title: "", message: "No near by vendors matches this criteria, please try another filterations options")
    }
    
}
