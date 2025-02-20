//
//  ScrumListView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 03.02.2025.
//

import SwiftUI

struct ScrumListView: View {
    @Binding var scrums: [DailyScrum]
    @State private var presentNewScrum = false
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: ScrumDetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    presentNewScrum = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add new scrum")
            }
        }
        .sheet(isPresented: $presentNewScrum) {
            ScrumCreateSheet(scrums: $scrums, presentNewScrum: $presentNewScrum)
        }
    }
}

#Preview {
    ScrumListView(scrums: .constant(SampleData.scrums))
}
