//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 01.02.2025.
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    
    struct Attendee: Identifiable, Codable {
        let id: UUID
        let name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    private(set) var history: [History] = []
        
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    
    mutating func updateHistory(transcript: String) {
        let scrumHistory = History(attendees: attendees, transcript: transcript)
        history.insert(scrumHistory, at: 0)
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .yellow)
    }
}
