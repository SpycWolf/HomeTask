//
//  ViewModifier.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/16.
//

import SwiftUI

struct LeftAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

extension View {
    func leftAligned() -> some View {
        return self.modifier(LeftAligned())
    }
}
