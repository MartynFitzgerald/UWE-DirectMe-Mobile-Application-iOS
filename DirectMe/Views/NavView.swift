//
//  SwiftUIView.swift
//  DirectMe
//
//  Created by martyn on 13/11/2019.
//  Copyright © 2019 martyn.fitzgerald. All rights reserved.
//


import SwiftUI

/*
struct SelectionModel{
    var selectionBackground: Int = 2 {
        didSet {
            switch selectionBackground {
                case 0:
                    UITabBar.appearance().backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 155/255, alpha: 1)
                case 1:
                    UITabBar.appearance().backgroundColor = UIColor(red: 153/255, green: 15/255, blue: 153/255, alpha: 1)
                case 2:
                    UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
                case 3:
                    UITabBar.appearance().backgroundColor = UIColor(red: 153/255, green: 15/255, blue: 15/255, alpha: 1)
                case 4:
                    UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 135/255, blue: 153/255, alpha: 1)
                default:
                    UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
            }
        }
    }
}
 */

struct NavView: View {
    
    init () {
        //Set defualt background color as green color
        UINavigationBar.appearance().shadowImage = UIImage()
        //UINavigationBar.appearance().backgroundImage = (UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    }
    
    @State private var selection = 2
    
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
            UnknownView()
                .tabItem {
                    VStack {
                        Image(systemName: "questionmark.circle")
                        Text("Unknown")
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
