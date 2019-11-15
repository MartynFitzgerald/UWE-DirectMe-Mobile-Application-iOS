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
        //Set defualt background color as green color
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor(red: 15/255, green: 157/255, blue: 88/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    @State private var selection = 2
    @State var enlargeIt1 : Bool = false

    
    var body: some View {
            TabView(selection: $selection){
                Text("Information View")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "info.circle.fill")
                            .animation(.interpolatingSpring(mass: 0.7, stiffness: 200, damping: 10, initialVelocity: 4))
                            Text("Info")
                        }
                        .onTapGesture {
                            self.enlargeIt1.toggle()
                        }
                    }
                    .tag(0)
                Text("Second View")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "questionmark.circle")
                            .animation(.interpolatingSpring(mass: 0.7, stiffness: 200, damping: 10, initialVelocity: 4))
                            Text("Unknown")
                        }
                        .onTapGesture {
                            self.enlargeIt1.toggle()
                        }
                    }
                    .tag(1)
                MapView()
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "map")
                            .animation(.interpolatingSpring(mass: 0.7, stiffness: 200, damping: 10, initialVelocity: 4))
                            Text("Map")
                        }
                        .onTapGesture {
                            self.enlargeIt1.toggle()
                        }
                    }
                    .tag(2)
                HistoryView()
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "clock")
                            .animation(.interpolatingSpring(mass: 0.7, stiffness: 200, damping: 10, initialVelocity: 4))
                            Text("History")
                        }
                        .onTapGesture {
                            self.enlargeIt1.toggle()
                        }
                    }
                    .tag(3)
                AccountView()
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                            .animation(.interpolatingSpring(mass: 0.7, stiffness: 200, damping: 10, initialVelocity: 4))
                            Text("Account")
                        }
                        .onTapGesture {
                            self.enlargeIt1.toggle()
                        }
                    }
                    .tag(4)
            }
            .accentColor(.white)
        
            //.navigationBarTitle(Text("Map"))
            //if selection == 4 {
            //    print(selection)
            //}
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
