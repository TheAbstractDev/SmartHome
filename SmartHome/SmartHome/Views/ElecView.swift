//
//  ElecView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct ElecView: View {
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        HStack {
            Image(systemName: "bolt")
                .imageScale(.large)
                .padding()
                .clipShape(Circle())
                .overlay(Circle().stroke(.tertiary, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text("\(String(viewModel.powerUsage)) ")
                    .fontWeight(.heavy)
                    .font(.title)
                +
                Text("Kwh")
                    .fontWeight(.medium)
                Text("Power usage for today")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.gray.opacity(0.6))
            }.padding(.leading, 10)
            Spacer()
        }
        .padding([.leading, .trailing], 30)
    }
}

struct ElecView_Previews: PreviewProvider {
    static var previews: some View {
        ElecView()
            .environmentObject(MainViewModel())
    }
}
