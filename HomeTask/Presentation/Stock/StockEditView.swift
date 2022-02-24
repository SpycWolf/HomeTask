//
//  EditStockView.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/16.
//

import SwiftUI

struct StockEditView: View {
    @Binding var stock: StockModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("stockTitle")
                    .font(.system(size: 18))
                Image(systemName: "asterisk")
                    .foregroundColor(.red)
                    .font(.system(size: 10))
                Spacer()
            }
            TextField("stockTitle", text: $stock.title)
                .font(.system(size: 16))
                .padding()
                .background(Color.bgwhite)
                .cornerRadius(10)
            Divider()
                .padding()
            Text("stockMemo")
                .font(.system(size: 18))
                .leftAligned()
            TextField("stockMemo", text: $stock.memo)
                .font(.system(size: 16))
                .padding()
                .background(Color.bgwhite)
                .cornerRadius(10)
            Divider()
                .padding()
            HStack {
                Text("stockAlert")
                    .font(.system(size: 18))
                Image(systemName: "asterisk")
                    .foregroundColor(.red)
                    .font(.system(size: 10))
                Spacer()
            }
            HStack {
                Slider(value: $stock.limit, in: 0...10, step: 1) {
                    Text("stockAlert")
                }
                .padding()
                Spacer()
                Text("\(Int(stock.limit))")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .padding()
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0,
                            leading: 16,
                            bottom: 0,
                            trailing: 16))
    }
}

struct StockEditView_Previews: PreviewProvider {
    static var previews: some View {
        StockEditView(stock: .constant(StockModel()))
        StockEditView(stock: .constant(StockModel.sample()[0]))
    }
}
