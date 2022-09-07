//
//  Animal+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 06/09/2022.
//

import Foundation

extension AnimalEntity {
    
    var age: Age {
        get {
            guard let ageValue = ageValue,
                    let age = Age(rawValue: ageValue) else { return Age.unknown }
            return age
        }
        
        set {
            self.ageValue = newValue.rawValue
        }
    }
    
    var coat: Coat {
        get {
            guard let coatValue = coatValue,
                    let coat = Coat(rawValue: coatValue) else {return Coat.unknown}
            return coat
        }
        
        set {
            self.coatValue = newValue.rawValue
        }
    }
    
    var gender: Gender {
        get {
            guard let genderValue = genderValue,
                    let gender = Gender(rawValue: genderValue) else {return Gender.unknown}
            return gender
        }
        
        set {
            self.genderValue = newValue.rawValue
        }
    }
    
    var size: Size {
        get {
            guard let sizeValue = sizeValue,
                    let size = Size(rawValue: sizeValue) else { return Size.unknown }
            return size
        }
        
        set {
            self.sizeValue = newValue.rawValue
        }
    }
    
    var status: AdoptionStatus {
      get {
        guard let statusValue = statusValue,
          let status = AdoptionStatus(rawValue: statusValue) else { return AdoptionStatus.unknown }
        return status
      }
      set {
        self.statusValue = newValue.rawValue
      }
    }
    
    @objc var breed: String {
        return breeds?.primary ?? breeds?.secondary ?? ""
    }
}
