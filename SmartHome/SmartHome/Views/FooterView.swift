//
//  FooterView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct FooterView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            MusicPlayerView()
                .cornerRadius(35)
                .offset(y: -55)
                .overlay {
                    HStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("prp", bundle: .main))

                        Spacer()
                        Image(systemName: "person.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray.opacity(0.5))
                        Spacer()
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray.opacity(0.5))
                        Spacer()
                        Image(systemName: "gear")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray.opacity(0.35))
                    }
                    .padding(50)
                    .frame(height: 100)
                    .background(colorScheme == .light ? .white : .black)
                    .cornerRadius(35)
                    .offset(y: 40)
                    .shadow(color: .black.opacity(0.1), radius: 10, y: -5)

                }
        }
        .background(Color(uiColor: UIColor(red: 69/255.0, green: 40/255.0, blue: 143/255.0, alpha: 1.000)))

    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
