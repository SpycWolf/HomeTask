//
//  ShoppingEmptyView.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import SwiftUI

struct ShoppingEmptyView: View {
    var body: some View {
        Text("stockEmptyLabel")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .listRowInsets(EdgeInsets(top: 24,
                                      leading: 0,
                                      bottom: 8,
                                      trailing: 0))
            .listRowBackground(Color.clear)
    }
}

struct ShoppingEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingEmptyView()
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
