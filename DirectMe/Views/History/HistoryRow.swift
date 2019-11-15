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
            VStack (alignment: .leading) {
                Text(history.name)
                    .font(.body)
                Text(history.state)
                    .font(.subheadline)
            }
        }
        .padding(10)
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistoryRow(history: historyData[0])
            HistoryRow(history: historyData[1])
        }.previewLayout(.fixed(width:300, height: 70))
    }
}
