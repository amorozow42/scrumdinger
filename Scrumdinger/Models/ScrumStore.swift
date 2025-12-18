//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 17.02.2025.
//

import SwiftUI

@Observable
class ScrumStore {
    var scrums: [DailyScrum] = []

    func load() async throws {
        guard let path = try? composePath() else {
            scrums = SampleData.scrums
            return
        }
        
        guard let data = try? Data(contentsOf: path) else {
            scrums = SampleData.scrums
            return
        }
            
        let savedScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
        
        if savedScrums.isEmpty {
            scrums = SampleData.scrums
        } else {
            scrums = savedScrums
        }
    }
    
    func save() async throws {
        guard let path = try? composePath() else {
            return
        }
        
        let data = try JSONEncoder().encode(scrums)

        do {
            try data.write(to: path)
        } catch {
            return
        }
    }
    
    private func composePath() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        .appending(path: "scrums.data")
    }
}
