//
//  ListView.swift
//  Moonshot
//
//  Created by Ahmet Haydar ISIK on 6/15/25.
//
import SwiftUI

  struct ListView: View {
        let astronauts: [String: Astronaut]
        let missions: [Mission]
        
      var body: some View {
          List(missions) { mission in
              NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                  HStack {
                      Image(mission.image)
                          .resizable()
                          .scaledToFit()
                          .frame(width: 80, height: 80)
                          .clipShape(Circle())
                      
                      VStack(alignment: .leading) {
                          Text(mission.displayName)
                              .font(.headline)
                              .foregroundStyle(.white)
                          
                          Text(mission.formattedLaunchDate)
                              .foregroundStyle(.white.opacity(0.5))
                             
                      }
                  }
                  .padding(.top, 2)
              }
              .listRowInsets(EdgeInsets())
              .listRowBackground(Color.darkBackground)
              .listRowSeparator(.hidden)
              .padding(.horizontal)
          }
          .listStyle(.plain)
      }
    }

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListView(astronauts: astronauts, missions: missions)
}
