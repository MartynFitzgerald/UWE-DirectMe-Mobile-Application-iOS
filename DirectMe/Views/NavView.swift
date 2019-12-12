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
        UINavigationBar.appearance().backgroundColor = Colours.red
        UINavigationBar.appearance().barTintColor = Colours.red
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //Set defaults of UITabBar
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = Colours.red
        UITabBar.appearance().unselectedItemTintColor = .systemGray
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
            AccountView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account")
                    }
                }
                .tag(3)
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
