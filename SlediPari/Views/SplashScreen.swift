//
//  SplashScreen.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/19/22.
//

import SwiftUI

struct SplashScreen: View {
    
    @ObservedObject private var viewModel = GetMonthsViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.completed {
                
                MonthView(allMonths: viewModel.allMonths)
            }
            else {
                
                Image("splash")
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .task {
            await viewModel.getAllMonths()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
