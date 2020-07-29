//
//  SharedData.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

class SharedData{
    
    static var phone: String?
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}
