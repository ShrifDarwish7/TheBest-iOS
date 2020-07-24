//
//  LoginPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didSuccessSendingCode()
    func didSuccessLogin()
    func didFailSendingCode()
    func didFailLogin()
    
}

class LoginViewPresenter{
    
    private var loginViewDelegate: LoginViewDelegate?
    
    init(loginViewDelegate: LoginViewDelegate) {
        self.loginViewDelegate = loginViewDelegate
    }
    
    func sendCodeTo(_ phone: String){
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                self.loginViewDelegate?.didFailSendingCode()
                print(error)
                return
            }

            UserDefaults.init().set(verificationID, forKey: "authVerificationID")
            SharedData.phone = phone
            self.loginViewDelegate?.didSuccessSendingCode()
            
        }
        
    }
    
    func signInWith(code: String){
        
        loginViewDelegate?.showSVProgress()
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: UserDefaults.init().string(forKey: "authVerificationID")!,
            verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            self.loginViewDelegate?.dismissSVProgress()
            if error != nil {
                print("err auth",error)
                self.loginViewDelegate?.didFailLogin()
                return
            }
            
            authResult?.user.getIDToken(completion: { (token, error) in
                
                if let token = token {
                
                    print("Token",token)
                    self.loginViewDelegate?.didSuccessLogin()
                   
                }else{
                    print("token fail")
                    self.loginViewDelegate?.didFailLogin()
                }
                
            })
        }
        
    }
    
}
