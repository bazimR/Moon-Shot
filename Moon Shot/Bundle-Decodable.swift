//
//  Bundle-Decodable.swift
//  Moon Shot
//
//  Created by Rishal Bazim on 25/02/25.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [String: Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) data.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([String:Astronaut].self, from: data) else {
            fatalError("Failed to decode from \(file)")
        }
        
        return loaded
    }
}
