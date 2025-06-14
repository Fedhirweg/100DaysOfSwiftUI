//
//  MissionView.swift
//  Moonshot
//
//  Created by Ahmet Haydar ISIK on 6/8/25.
//

import SwiftUI

struct MissionView: View {
    let mission : Mission
    let crew: [CrewMember]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var body: some View {
        ScrollView{
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) {
                        width, axis in width * 0.6
                    }
                    .padding(.top)
                
                Text(mission.formattedLaunchDate)
                    .font(.title2.bold())
                    
                    
                
                VStack(alignment: .leading) {
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                     
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
        
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                   CrewMemberView(crewMember: crewMember.astronaut, role: crewMember.role)
                                }
                            }
                        }
                    }
                    
                    
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        
       
    }
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}


    #Preview {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        
        return MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
