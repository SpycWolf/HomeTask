//
//  MainListView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/13.
//

import SwiftUI

struct StockRowView: View {
    @Binding var stock: Stock

    private var warning: Bool {
        stock.amount < stock.limit
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
                Text(stock.memo ?? "")
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
                Button(action: {}) {
                    Image(systemName: "plus.square")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0,
                                    leading: 0,
                                    bottom: 8,
                                    trailing: 0))
                Button(action: {}) {
                    Image(systemName: "minus.square")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .padding(EdgeInsets(top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 16))
            Button(action: {}) {
                Image(systemName: "bag.badge.plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(warning ? Color.yellow : Color.bgwhite)
        .cornerRadius(16)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        StockRowView(stock: .constant(Stock.sample()[0]))
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
