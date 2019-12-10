//
//  InformationView.swift
//  DirectMe
//
//  Created by martyn on 19/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        NavigationView {
        VStack {
            Form {
                Section(header: Text("About Us")) {
                    HStack {
                        Image("LogoRed")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                    }
                    VStack(alignment: .leading) {
                        Text("Description:")
                        HStack {
                            Text("This application is to make finding a car parks quickly and dynamic. This application allows you to search a location either by coordinates (x,y) or a name (Temple Meads). When searching for a location, the application will only show car parks in the radius specified in general settings under your account.")
                            .font(.footnote)
                        }
                        Spacer()
                        HStack {
                            Text("The information of car parks is sourced from Google and other sources will be incorporated in the future. You can also change non-sensitive information give in the registration under your account.")
                            .font(.footnote)
                        }
                    }
                    HStack {
                        Text("Author:")
                        Spacer()
                        Text("Martyn Fitzgerald")
                            .font(.body)
                    }
                    HStack {
                        Text("Contact Email:")
                        Spacer()
                        Text("martyn2.fitzgerald@live.uwe.ac.uk")
                            .font(.footnote)
                    }
                    
                    HStack {
                        Text("Software Version:")
                        Spacer()
                        Text("0.37.5")
                        .font(.body)
                    }
                }
            }
            .navigationBarTitle(Text("Information"), displayMode: .inline)
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
