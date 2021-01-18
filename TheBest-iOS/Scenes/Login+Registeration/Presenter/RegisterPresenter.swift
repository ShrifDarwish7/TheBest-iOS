//
//  RegisterPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol RegisterViewDelegate {
    
    func showSVProgess()
    func didSuccessfulyRegistering()
    func didFailRegistering()
    func dismissSVProgress()
    
}

class RegisterViewPresenter{
    
    private var registerViewDelegate: RegisterViewDelegate?
    
    init(registerViewDelegate: RegisterViewDelegate) {
        self.registerViewDelegate = registerViewDelegate
    }
    
    func registerWith(parameters: [String: String]){
        
        registerViewDelegate?.showSVProgess()
        
        AuthServices.registerWith(parameters: parameters) { (completed) in
            
            self.registerViewDelegate?.dismissSVProgress()
            
            if completed{
                self.registerViewDelegate?.didSuccessfulyRegistering()
            }else{
                self.registerViewDelegate?.didFailRegistering()
            }
            
        }
        
    }
    
}
