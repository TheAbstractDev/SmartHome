//
//  HeaderView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome Home")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.gray.opacity(0.6))
                Text("\(viewModel.user.firstname) \(viewModel.user.lastname)")
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            Image("user")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
        }
        .padding(.vertical, 30)
        .padding(.horizontal)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .environmentObject(MainViewModel())
    }
}
