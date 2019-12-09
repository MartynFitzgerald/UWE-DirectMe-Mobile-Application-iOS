//
//  HistoryView.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    
    var body: some View {
        NavigationView {
            List (historyData) { history in
                NavigationLink(destination: HistoryDetail(history: history)) {
                    HistoryRow(history: history)
                }
            }
            .navigationBarTitle(Text("History"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    signOut()
                }, label: {
                    HStack{
                        Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .frame(width: 20.0, height: 20.0, alignment: .center)
                        .rotationEffect(.degrees(-90))
                        Text("Sign Out")
                    }
                })
            )
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
