//
//  HistoryDetail.swift
//  DirectMe
//
//  Created by martyn on 14/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct HistoryDetail: View {
    var history: History
    
    var body: some View {
        VStack {
            HistoryMapView(coordinate: history.locationCoordinate)
                .frame(height: 200)

            CircleImage(image: history.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text(history.name)
                    .font(.title)

                HStack(alignment: .top) {
                    Text(history.park)
                        .font(.subheadline)
                    Spacer()
                    Text(history.state)
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(Text(history.name), displayMode: .inline)
    }
}

struct HistoryDetail_Preview: PreviewProvider {
    static var previews: some View {
        HistoryDetail(history: historyData[0])
    }
}
