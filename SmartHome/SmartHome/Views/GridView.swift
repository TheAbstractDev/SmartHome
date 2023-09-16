//
//  GridView.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct GridView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: MainViewModel
    @State var isPresented: Bool = false
    @State var selectedRoom = -1

    let columns = [
        GridItem(.flexible(), spacing: -5),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(viewModel.rooms, id: \.id) { room in
                Button {
                    selectedRoom = room.id
                    isPresented.toggle()
                } label: {
                    RoundedStack(isFirst: room.id == 0, color: Color("org", bundle: .main)) {
                        Image(systemName: room.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(room.id == 0 ? .white : Color("org", bundle: .main))
                        Spacer()
                        Text(room.name)
                            .bold()
                            .foregroundColor(room.id == 0 ? .white : colorScheme == .dark ? .white.opacity(0.4) : .black)
                        Text("\(room.devices.count) Device")
                            .bold()
                            .foregroundColor(room.id == 0 ? .white.opacity(0.6) : colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
                    }
                }
                .sheet(isPresented: $isPresented, content: {
                    DetailView()
                })
            }
        }
        .onAppear {
            viewModel.getRooms()
        }
    }
}


struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
            .environmentObject(MainViewModel())
    }
}
