//
//  History.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 13.02.2025.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    let attendees: [DailyScrum.Attendee]
    
    init(id: UUID = UUID(), date: Date = Date.now, attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
