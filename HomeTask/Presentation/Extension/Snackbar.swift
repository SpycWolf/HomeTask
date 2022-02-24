//
//  Snackbar.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/24.
//

import SwiftUI

struct Snackbar: View {
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @Binding var isShowing: Bool
    
    private let presenting: AnyView
    private let text: Text
    private let actionText: Text?
    private let action: (() -> Void)?
    
    private var isBeingDismissedByAction: Bool {
        actionText != nil && action != nil
    }
    
    init<Presenting>(isShowing: Binding<Bool>, presenting: Presenting, text: Text,
                     actionText: Text? = nil, action: (() -> Void)? = nil) where Presenting: View {
        _isShowing = isShowing
        self.presenting = AnyView(presenting)
        self.text = text
        self.actionText = actionText
        self.action = action
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.presenting
                VStack {
                    Spacer()
                    if self.isShowing {
                        HStack {
                            self.text.foregroundColor(self.colorScheme == .light ? .white : .lead)
                            Spacer()
                            if (self.actionText != nil && self.action != nil) {
                                self.actionText!
                                    .fontWeight(.bold)
                                    .foregroundColor(self.colorScheme == .light ? .white : .lead)
                                    .onTapGesture {
                                        self.action?()
                                        withAnimation {
                                            self.isShowing = false
                                        }
                                    }
                            }
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.9, height: 50)
                        .shadow(radius: 3)
                        .background(self.colorScheme == .light ? Color.lead : Color.white)
                        .offset(x: 0, y: -20)
                        .transition(.asymmetric(insertion: .move(edge: .bottom),
                                                removal: .move(edge: .trailing)))
                        .onAppear {
                            guard !self.isBeingDismissedByAction else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.spring()) {
                                    self.isShowing = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension View {
    func snackBar(isShowing: Binding<Bool>, text: Text,
                  actionText: Text? = nil, action: (() -> Void)? = nil) -> some View {
        Snackbar(isShowing: isShowing,
                 presenting: self,
                 text: text,
                 actionText: actionText,
                 action: action)
    }
    
}
