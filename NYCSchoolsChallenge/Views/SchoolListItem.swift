//
//  SchoolListItem.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import SwiftUI

struct SchoolListItem: View {
    let school: School
    
    var body: some View {
        Text(school.schoolName)
    }
}

struct SchoolListItem_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListItem(school: School.sampleData[0])
    }
}
