//
//  ProfilePresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol ProfileViewDelegate {
    func showProgress()
    func dismissProgress()
    func didCompleteUpdateProfileWith(_ updated: Bool)
}

class ProfilePresenter{
    
    var profileViewDelegate: ProfileViewDelegate?
    
    init(profileViewDelegate: ProfileViewDelegate) {
        self.profileViewDelegate = profileViewDelegate
    }
    
    func updateProfile(parameters: [String: String]){
        self.profileViewDelegate?.showProgress()
        AuthServices.updateProfileWith(parameters: parameters) { (updated) in
            self.profileViewDelegate?.dismissProgress()
            if updated{
                self.profileViewDelegate?.didCompleteUpdateProfileWith(true)
            }else{
                self.profileViewDelegate?.didCompleteUpdateProfileWith(false)
            }
        }
    }
    
}
