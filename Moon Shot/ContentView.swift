//
//  ContentView.swift
//  Moon Shot
//
//  Created by Rishal Bazim on 25/02/25.
//

import SwiftUI

struct MissionCard: View {
    let mission: Mission
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100).padding()
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(mission.formattedLaunchDate).font(
                    .caption
                ).foregroundColor(.white.opacity(0.6))
            }.frame(maxWidth: .infinity).padding()
                .background(
                    .darkBackground
                )
        }.clipShape(.rect(cornerRadius: 10)).overlay {
            RoundedRectangle(cornerRadius: 10).stroke(
                .lightBackground)
        }.padding(5)
    }
}

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    let column = [
        GridItem(.adaptive(minimum: 120))
    ]
    var body: some View {
        LazyVGrid(columns: column) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(
                        mission: mission,
                        astronauts: astronauts
                    )
                } label: {
                    MissionCard(mission: mission)
                }

            }
        }.padding([.horizontal, .bottom])
    }
}
struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        LazyVStack {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(
                        mission: mission,
                        astronauts: astronauts
                    )
                } label: {
                    MissionCard(mission: mission)
                }

            }
        }.padding([.horizontal, .bottom])
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var toggleView: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if toggleView {
                        ListLayout(missions: missions, astronauts: astronauts)
                    } else {
                        GridLayout(missions: missions, astronauts: astronauts)
                    }
                }

            }.navigationTitle("Moon Shot").preferredColorScheme(.dark).toolbar {
                if toggleView {
                    Button {
                        hanldeToggleView()
                    } label: {
                        Image(systemName: "square.grid.2x2")
                    }
                } else {
                    Button {
                        hanldeToggleView()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
    }

    func hanldeToggleView() {
        withAnimation(.bouncy) {
            toggleView.toggle()
        }

    }
}

#Preview {
    ContentView()
}
