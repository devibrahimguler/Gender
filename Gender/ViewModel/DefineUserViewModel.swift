//
//  DefineUserViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.07.2023.
//

import SwiftUI

class DefineUserViewModel: ObservableObject {

    @Published var isDefineUser = false
    @Published var showPicker: Bool = false
    
    @Published var defineCount = 1
    @Published var defineBirthDayD1 = ""
    @Published var defineBirthDayD2 = ""
    @Published var defineBirthDayM1 = ""
    @Published var defineBirthDayM2 = ""
    @Published var defineBirthDayY1 = ""
    @Published var defineBirthDayY2 = ""
    @Published var defineBirthDayY3 = ""
    @Published var defineBirthDayY4 = ""
    
    @Published var foto1 : UIImage? = nil
    @Published var foto2 : UIImage? = nil
    @Published var foto3 : UIImage? = nil
    @Published var foto4 : UIImage? = nil
    @Published var foto5 : UIImage? = nil
    @Published var foto6 : UIImage? = nil
    
    @Published var selectedSchool = ""
    
    @Published var selectedLook = ""
    
    @Published var selectedInterested = ""
    
    @Published var selectedGender = ""
    @Published var isVisibleGender = false
    
    @Published var selectedTagsOrientation = 0
    @Published var selectedOrientation : [String] = []
    @Published var isVisibleOrientation = false
    
    @Published var definePosition : CGPoint = CGPoint()
    
    @Published var totalHeight = CGFloat.zero
    @Published var selectedTags = 0
    @Published var selectedList : [String] = []
    @Published var tags: [String] = ["Lorem", "Ipsum", "dolor", "consectetur", "adipiscing", "elit", "Nam", "semper", "sit", "amet", "ut", "eleifend", "Cras"]
    
    @Published var rotation = 30.0
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var age: String = ""
    
}
