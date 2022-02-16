//
//  MainListView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct StockRowView: View {
    let stock: StockModel
    
    var incrementAction: () -> Void
    var decrementAction: () -> Void
    var addBagAction: () -> Void
    
    private var warning: Bool {
        stock.amount < Int(stock.limit)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                Text(stock.title)
                    .font(.system(size: 18))
                    .lineLimit(nil)
                    .padding(EdgeInsets(top: 0,
                                        leading: 0,
                                        bottom: 8,
                                        trailing: 0))
                Spacer()
                Text(stock.memo)
                    .font(.system(size: 14))
                    .lineLimit(nil)
                Spacer()
            }
            Spacer()
            Text("\(stock.amount)")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(.orange)
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
            Button(action: addBagAction) {
                Image(systemName: "bag.badge.plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(warning ? Color.yellow : Color.bgwhite)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8,
                                  leading: 0,
                                  bottom: 8,
                                  trailing: 0))
        .cornerRadius(8)
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        StockRowView(stock: StockModel.sample()[0],
                     incrementAction: {},
                     decrementAction: {},
                     addBagAction: {})
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
