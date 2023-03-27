//
//  SchoolDetailScreen.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/26/23.
//

import SwiftUI

struct SchoolDetailScreen: View {
    let school: School
    
    var body: some View {
        Text(school.schoolName)
    }
}

struct SchoolDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailScreen(school: School.sampleData[0])
    }
}
