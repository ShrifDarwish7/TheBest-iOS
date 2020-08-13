//
//  Markets+MarketsViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension MarketsVC: MarketsViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithNearByMarkets(_ result: NearByMarkets) {
        self.nearbyMarkets = result
        self.tableDataSource = result.paginate.data
        self.loadTable()
    }
    
}
