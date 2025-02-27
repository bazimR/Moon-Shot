//
//  MissionView.swift
//  Moon Shot
//
//  Created by Rishal Bazim on 26/02/25.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
struct Seperator: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct CrewCard: View {
    let crew: CrewMember
    var body: some View {
        HStack {
            Image(crew.astronaut.id)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(.capsule).overlay {
                    Capsule().stroke(
                        .lightBackground, lineWidth: 2)
                }
            VStack(alignment: .leading) {
                Text(crew.astronaut.name).font(
                    .headline
                ).foregroundColor(.white)
                Text(crew.role)
                    .foregroundColor(
                        .white.opacity(0.6))
            }
        }.padding(.horizontal)
    }
}
struct MissionView: View {
    let mission: Mission
    let crews: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crews = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                VStack(alignment: .leading) {
                    Text(mission.formattedLaunchDate).font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 5)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Seperator()
                    Text(mission.description)
                    Seperator()
                    Text("Crews").font(.title.bold()).padding(.bottom, 5)
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crews, id: \.role) { crew in
                            NavigationLink {
                                AstronautView(astronaut: crew.astronaut)
                            } label: {
                                CrewCard(crew: crew)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
