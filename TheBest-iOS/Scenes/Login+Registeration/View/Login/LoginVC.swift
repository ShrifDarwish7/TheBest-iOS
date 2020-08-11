//
//  LoginVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import Closures
import FirebaseAuth
import SVProgressHUD

class LoginVC: UIViewController , FPNTextFieldDelegate{
    
    @IBOutlet weak var FPNContainer: UIView!
    @IBOutlet weak var sendCodeBtn: UIButton!
    @IBOutlet weak var phoneContainer: UIView!
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var code5: UITextField!
    @IBOutlet weak var code6: UITextField!
    @IBOutlet weak var codeView: UIView!
    
    
    var FPNTextfield : FPNTextField?
    var dialCode = "+20"
    var selectedFPNContryCode: String?
    
    var loginViewPresenter: LoginViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewPresenter = LoginViewPresenter(loginViewDelegate: self)
        
        code1.addTarget(self, action: #selector(beginEnterCode(textField:)), for: .editingChanged)
        code2.addTarget(self, action: #selector(beginEnterCode(textField:)), for: .editingChanged)
        code3.addTarget(self, action: #selector(beginEnterCode(textField:)), for: .editingChanged)
        code4.addTarget(self, action: #selector(beginEnterCode(textField:)), for: .editingChanged)
        code5.addTarget(self, action: #selector(beginEnterCode(textField:)), for: .editingChanged)
        code6.addTarget(self, action: #selector(beginEnterCode(textField:)), for: .editingChanged)
        
       loadUI()
        loadBtnsActions()
    }
    

    func loadUI(){
        
        FPNTextfield = FPNTextField(frame: CGRect(x: 50, y: 0, width: self.view.frame.width - 40, height: FPNContainer.frame.height))
       // FPNTextfield!.font = "Lang".Localized == "ar" ? UIFont(name: FONT_AR, size: 14) : UIFont(name: FONT_EN, size: 14)
        FPNTextfield!.delegate = self
        FPNTextfield!.setCountries(excluding: [FPNCountryCode.IL,FPNCountryCode.QA])
        FPNTextfield!.setFlag(countryCode: FPNCountryCode.EG)
        FPNTextfield!.keyboardType = .asciiCapableNumberPad
        FPNTextfield!.hasPhoneNumberExample = true
        FPNTextfield!.semanticContentAttribute = .forceLeftToRight
        FPNTextfield!.textAlignment = .left
        FPNContainer.addSubview(FPNTextfield!)
        FPNContainer.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        FPNContainer.layer.borderWidth = 1.5
        FPNContainer.layer.cornerRadius = 15
        
        sendCodeBtn.layer.cornerRadius = 10
        
    }
    

        @objc func beginEnterCode(textField: UITextField){
            
            let  char = textField.text!.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")

            switch textField.tag{
            case 1:
                if (isBackSpace == -92) {
                    break
                }
                code2.becomeFirstResponder()
            case 2:
                if (isBackSpace == -92) {
                    code1.becomeFirstResponder()
                    break
                }
                code3.becomeFirstResponder()
            case 3:
                if (isBackSpace == -92) {
                    code2.becomeFirstResponder()
                    break
                }
                code4.becomeFirstResponder()
            case 4:
                if (isBackSpace == -92) {
                    code3.becomeFirstResponder()
                    break
                }
                code5.becomeFirstResponder()
            case 5:
                if (isBackSpace == -92) {
                    code4.becomeFirstResponder()
                    break
                }
                code6.becomeFirstResponder()
            case 6:
                if (isBackSpace == -92) {
                    code5.becomeFirstResponder()
                    break
                }
                code6.becomeFirstResponder()
            default:
                break
            }
            
            guard !(self.code1.text?.isEmpty)!,!(self.code2.text?.isEmpty)!,!(self.code3.text?.isEmpty)!,!(self.code4.text?.isEmpty)!,!(self.code5.text?.isEmpty)!, !(self.code6.text?.isEmpty)! else {
                return
            }
            let code = (self.code1.text! + self.code2.text! + self.code3.text! + self.code4.text! + self.code5.text!)
            self.loginViewPresenter?.signInWith(code: code + self.code6.text!)
            
        }
    
    func loadBtnsActions(){
        
        sendCodeBtn.onTap {
            guard !(self.FPNTextfield?.text!.isEmpty)! else{
                self.showAlert(title: "", message: "Please enter your phone number")
                return
            }
            SVProgressHUD.show()
            self.loginViewPresenter?.sendCodeTo(self.dialCode + self.FPNTextfield!.text!.replacingOccurrences(of: " ", with: ""))
        }
        
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        self.dialCode = dialCode
        self.selectedFPNContryCode = code
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
    }
    
    func fpnDisplayCountryList() {
        
    }
    

}
