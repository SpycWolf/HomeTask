//
//  StockDetailView.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/16.
//

import SwiftUI

struct StockDetailView: View {
    let stock: StockModel.Data
    
    var editAction: () -> Void
    var deleteAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Text("品名")
                        .font(.system(size: 18))
                    Image(systemName: "asterisk")
                        .foregroundColor(.red)
                        .font(.system(size: 10))
                    Spacer()
                }
                Text(stock.title)
                    .font(.system(size: 16))
                    .padding()
                    .background(Color.bgwhite)
                    .cornerRadius(10)
                Divider()
                    .padding()
            }
            Group {
                Text("メモ")
                    .font(.system(size: 18))
                    .leftAligned()
                Text(stock.memo)
                    .font(.system(size: 16))
                    .padding()
                    .background(Color.bgwhite)
                    .cornerRadius(10)
                Divider()
                    .padding()
            }
            Group {
                HStack {
                    Text("アラート設定")
                        .font(.system(size: 18))
                    Image(systemName: "asterisk")
                        .foregroundColor(.red)
                        .font(.system(size: 10))
                    Spacer()
                }
                Text("\(Int(stock.limit))個以下でアラート表示")
                    .font(.system(size: 16))
                    .padding()
                    .background(Color.bgwhite)
                    .cornerRadius(10)
            }

            Group {
                HStack {
                    Spacer()
                    Button(action: editAction) {
                        Text("編集する")
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(Color.white)
                    .font(.system(size: 18))
                    .frame(height: 55)
                    Spacer()
                }
                .background(Color.blue)
                .cornerRadius(10)
                HStack {
                    Spacer()
                    Button(action: deleteAction) {
                        Text("削除する")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(Color.red)
                    .font(.system(size: 18))
                    .frame(height: 55)
                    Spacer()
                }
                .border(.red, width: 1)
                .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .padding(EdgeInsets(top: 16,
                            leading: 16,
                            bottom: 0,
                            trailing: 16))
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stock: StockModel.sample()[0].data,
                        editAction: {},
                        deleteAction: {})
    }
}
