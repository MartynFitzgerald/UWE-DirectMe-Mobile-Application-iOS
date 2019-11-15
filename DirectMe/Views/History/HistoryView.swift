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
        NavigationView{
            List (historyData) { history in
                NavigationLink(destination: HistoryDetail(history: history)) {
                    HistoryRow(history: history)
                }
            }
            .navigationBarTitle(Text("History"))
        }
    }//.appearance().backgroundColor = UIColor(red: 244/255, green: 160/255, blue: 0/255, alpha: 1)
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
