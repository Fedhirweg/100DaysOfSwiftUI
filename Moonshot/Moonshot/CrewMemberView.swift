//
//  CrewListView.swift
//  Moonshot
//
//  Created by Ahmet Haydar ISIK on 6/14/25.
//

import SwiftUI

struct CrewMemberView: View {
    let crewMember: Astronaut
    let role : String
    
    var body: some View {
                        HStack {
                            Image(crewMember.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay {
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return CrewMemberView(crewMember: astronauts["armstrong"]!, role: "Commander")
        .preferredColorScheme(.dark)
}
