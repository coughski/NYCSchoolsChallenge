//
//  Statistic.swift
//  NYCSchoolsChallenge
//
//  Created by Kuba Szulaczkowski on 3/27/23.
//

import SwiftUI

struct Statistic<Label, Content>: View where Label : View, Content : View {
    let label: Label
    let content: Content
    
    init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.content = content()
    }
    
    var body: some View {
        Group {
            LabeledContent {
                content
            } label: {
                label
            }
        }
        .labeledContentStyle(.vertical)
    }
}

extension Statistic where Label == Text, Content == Text {
    init<S, F>(_ label: S, statistic: F.FormatInput?, format: F) where S : StringProtocol, F : FormatStyle, F.FormatInput : Equatable, F.FormatOutput == String {
        self.label = Text(label)
        
        if let statistic {
            self.content = Text(statistic, format: format)
        } else {
            self.content = Self.placeholder
        }
    }
    
    init<S>(_ label: S, statistic: S?) where S : StringProtocol {
        self.label = Text(label)
        if let statistic {
            self.content = Text(statistic)
        } else {
            self.content = Self.placeholder
        }
    }
    
    private static var placeholder: Text {
        Text("—")
    }
}
