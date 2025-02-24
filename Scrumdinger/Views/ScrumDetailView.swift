//
//  ScrumDetailView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 04.02.2025.
//

import SwiftUI

struct ScrumDetailView: View {
    @Binding var scrum: DailyScrum
    @State private var editViewPresent = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(.tint)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(8)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(8)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")) {
                ForEach($scrum.attendees) { $attendee in
                    Toggle(isOn: $attendee.isAvailable) {
                        Label("\(attendee.name)", systemImage: "person")
                    }
                }
            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                } else {
                    ForEach(scrum.history) { history in
                        NavigationLink(destination: HistoryView(history: history)) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                editViewPresent = true
            }
        }
        .sheet(isPresented: $editViewPresent) {
            ScrumEditSheet(scrum: $scrum, editViewPresent: $editViewPresent)
        }
    }
}

#Preview {
    NavigationStack {
        ScrumDetailView(scrum: .constant(SampleData.scrums[0]))
    }
}
