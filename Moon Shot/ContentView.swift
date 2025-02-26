//
//  ContentView.swift
//  Moon Shot
//
//  Created by Rishal Bazim on 25/02/25.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let column = [
        GridItem(.adaptive(minimum: 120))
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: column) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(
                                mission: mission,
                                astronauts: astronauts
                            )
                        } label: {
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
                }.padding([.horizontal, .bottom])
            }.navigationTitle("Moon Shot").preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
