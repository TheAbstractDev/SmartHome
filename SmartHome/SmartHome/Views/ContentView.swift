//
//  ContentView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MainViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView()
                .environmentObject(viewModel)
            ElecView()
                .environmentObject(viewModel)
                .padding(.top, -15)
            Spacer()
            ScrollView(.vertical) {
                GridView()
                    .environmentObject(viewModel)
            }
            .padding(.vertical)
            .padding(.horizontal, 1)
            Spacer()
            FooterView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

