//
//  ShoppingRowView.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/23.
//

import SwiftUI

struct ShoppingRowView: View {
    let item: ShoppingModel
    
    var incrementAction: () -> Void
    var decrementAction: () -> Void
    var purchaseAction: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                Text(item.stock.title)
                    .font(.system(size: 18))
                    .lineLimit(nil)
                    .padding(EdgeInsets(top: 0,
                                        leading: 0,
                                        bottom: 8,
                                        trailing: 0))
                Spacer()
                Text(item.stock.memo)
                    .font(.system(size: 14))
                    .lineLimit(nil)
                Spacer()
            }
            Spacer()
            Text("\(item.amount)")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 16))
            VStack {
                Button(action: incrementAction) {
                    Image(systemName: "plus.square")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                .buttonStyle(.borderless)
                .padding(EdgeInsets(top: 0,
                                    leading: 0,
                                    bottom: 8,
                                    trailing: 0))
                Button(action: decrementAction) {
                    Image(systemName: "minus.square")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                .buttonStyle(.borderless)
            }
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 16))
            Button(action: purchaseAction) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(item.purchased ? .green : .gray)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(Color.white)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8,
                                  leading: 0,
                                  bottom: 8,
                                  trailing: 0))
        .cornerRadius(8)
    }
}

struct ShoppingRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingRowView(item: ShoppingModel.sample()[0],
                        incrementAction: {},
                        decrementAction: {},
                        purchaseAction: {})
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
