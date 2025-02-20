//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 17.02.2025.
//

import SwiftUI

@MainActor
@Observable
class ScrumStore {
    var scrums: [DailyScrum] = []
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        .appendingPathComponent("scrums.data")
    }

    func load() async throws {
        let url = try fileURL()
        
        print(url)
        
        guard let data = try? Data(contentsOf: url) else {
            scrums = []
            return
        }
            
        scrums = try JSONDecoder().decode([DailyScrum].self, from: data)
    }
    
    func save() async throws {
        let data = try JSONEncoder().encode(scrums)
        try data.write(to: fileURL())
    }
}
