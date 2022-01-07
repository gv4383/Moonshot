//
//  AstronautSliderView.swift
//  Moonshot
//
//  Created by Goyo Vargas on 1/7/22.
//

import SwiftUI

struct AstronautSliderView: View {
    let crew: [Mission.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    init(crew: [Mission.CrewMember]) {
        self.crew = crew
    }
}

struct AstronautSliderView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let crew: [Mission.CrewMember] = missions[0].crew.map { member in
        let astronaut = astronauts[member.name]
        
        return Mission.CrewMember(role: member.role, astronaut: astronaut!)
    }
    
    static var previews: some View {
        AstronautSliderView(crew: crew)
    }
}
