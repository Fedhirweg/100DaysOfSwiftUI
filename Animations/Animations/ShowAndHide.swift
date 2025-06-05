//
//  ShowAndHide.swift
//  Animations
//
//  Created by Ahmet Haydar ISIK on 30/12/24.
//

import SwiftUI

struct ShowAndHide: View {
    
    @State private var isShowingRed = false
    
    
    var body: some View {

        VStack{
            Button ("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if (isShowingRed) {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

#Preview {
    ShowAndHide()
}
