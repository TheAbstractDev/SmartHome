//
//  RoundedStack.swift
//  SmartHome
//
//  Created by Sofiane Beors on 26/05/2023.
//

import SwiftUI

struct RoundedStack<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    var isFirst: Bool
    var color: Color
    let content: Content
    
    init(isFirst: Bool, color: Color, @ViewBuilder _ content: () -> Content) {
        self.isFirst = isFirst
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                content
            }
            Spacer()
        }
        .frame(width: 150, height: 150)
        .padding()
        .background(isFirst ? color : Color(uiColor: .secondarySystemBackground))
        .foregroundColor(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


struct RoundedStack_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            RoundedStack(isFirst: true, color: .blue) {
                
            }
            RoundedStack(isFirst: false, color: .purple) {
                
            }
        }
    }
}
