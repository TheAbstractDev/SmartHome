//
//  MusicPlayerView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct MusicPlayerView: View {
    var body: some View {
        HStack {
            Image("mj")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.black.opacity(0.5))
                        .overlay {
                            Image(systemName: "waveform")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                }
            
            VStack(alignment: .leading) {
                Text("Beat it")
                    .bold()
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 1)
                Text("Michael Jackson")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
            }
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                Image(systemName: "forward.frame")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Image(systemName: "pause")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("org", bundle: .main))
                    .cornerRadius(12)
            }.padding()
            
        }
        .padding()
        .background(Color("prp", bundle: .main))            
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView()
    }
}
