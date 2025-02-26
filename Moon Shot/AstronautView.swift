//
//  AstronautView.swift
//  Moon Shot
//
//  Created by Rishal Bazim on 26/02/25.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.9
                    }.clipShape(.rect(cornerRadius: 15)).overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.lightBackground, lineWidth: 2)
                    }.padding(.vertical)
                Text(astronaut.description).padding(.bottom)

            }.padding()
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    AstronautView(astronaut: astronauts["white"]!).preferredColorScheme(.dark)
}
