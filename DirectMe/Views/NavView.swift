//
//  SwiftUIView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//


import SwiftUI

struct NavView: View {
    
    @State private var selection = 2
    
    init () {
        //Set defualts of UINavigationBar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = Colours.green
        UINavigationBar.appearance().barTintColor = Colours.green
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //Set defaults of UITabBar
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = Colours.green
        UITabBar.appearance().unselectedItemTintColor = Colours.lightGrey
    }
    
    var body: some View {
        TabView(selection: $selection){
            InformationView()
                .tabItem {
                    VStack {
                        Image(systemName: "info.circle.fill")
                        Text("Info")
                    }
                }
                .tag(0)
            CarParkView()
                .tabItem {
                    VStack {
                        Image(systemName: "p.square.fill")
                        Text("Car Parks")
                    }
                }
                .tag(1)
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                .tag(2)
            HistoryView()
                .tabItem {
                    VStack {
                        Image(systemName: "clock")
                        Text("History")
                    }
                }
                .tag(3)
            AccountView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account")
                    }
                }
                .tag(4)
        }
        .accentColor(.white)
        .edgesIgnoringSafeArea(.top)
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
