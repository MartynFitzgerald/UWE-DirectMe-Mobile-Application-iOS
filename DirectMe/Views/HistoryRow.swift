//
//  HistoryRow.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct HistoryRow: View {
    var history: History
    
    var body: some View {
        HStack{
            Image(systemName: "clock")
                .resizable()
                .frame(width: 50, height: 50)
            Text(history.name)
        }
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(history: historyData[0])
    }
}
