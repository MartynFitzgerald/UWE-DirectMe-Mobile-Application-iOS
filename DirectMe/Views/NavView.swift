//
//  SwiftUIView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//

import SwiftUI

struct NavView: View {
    init () {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        //UITabBar.appearance().unselectedItemFontSize =
        
    }
    
    @State private var selection = 2
    
    var body: some View {
        NavigationView
        {
            TabView(selection: $selection){
                Text("Information View")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "info.circle.fill")
                            Text("Info")
                        }
                    }
                    .tag(0)
                Text("Second View")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "questionmark.circle")
                            Text("Unknown")
                        }
                    }
                    .tag(1)
                MapView()
                    .navigationBarTitle(Text("Map"))
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "map")
                            Text("Map")
                        }
                    }
                    .tag(2)
                HistoryView()
                    .navigationBarTitle(Text("History"))
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "clock")
                            Text("History")
                        }
                    }
                    .tag(3)
                AccountView()
                    .navigationBarTitle(Text("Account"))
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Account")
                        }
                    }
                    .tag(4)
            }
            .accentColor(.white)
            .navigationBarTitle(Text("Map"))	
        }
    }
    /*
    switch selection {
    case 0:
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
    case 1:
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
    case 2:
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
    case 3:
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
    case 4:
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
    default:
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
    }*/
    
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
