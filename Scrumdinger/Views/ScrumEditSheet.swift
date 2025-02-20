//
//  EditScrumSheet.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 14.02.2025.
//

import SwiftUI

struct ScrumEditSheet: View {
    @State private var editingScrum = DailyScrum.emptyScrum

    @Binding var scrum: DailyScrum
    @Binding var editViewPresent: Bool
    
    var body: some View {
        NavigationStack {
            ScrumEditView(scrum: $editingScrum)
                .navigationTitle(scrum.title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            editViewPresent = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            editViewPresent = false
                            scrum = editingScrum
                        }
                    }
                }
        }
        .onAppear {
            editingScrum = scrum
        }
    }
}

#Preview {
    ScrumEditSheet(scrum: .constant(SampleData.scrums[0]), editViewPresent: .constant(true))
}
