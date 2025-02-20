//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 13.02.2025.
//

import SwiftUI

struct ScrumCreateSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    @Binding var presentNewScrum: Bool
    
    var body: some View {
        NavigationStack {
            ScrumEditView(scrum: $newScrum)
                .navigationTitle("New Scrum")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            presentNewScrum = false
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            presentNewScrum = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ScrumCreateSheet(scrums: .constant(SampleData.scrums), presentNewScrum: .constant(true))
}
