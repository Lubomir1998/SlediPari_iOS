//
//  ContentView.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        SplashScreen()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
