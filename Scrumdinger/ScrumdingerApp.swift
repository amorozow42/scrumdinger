//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 30.01.2025.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrumStore = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ScrumListView(scrums: $scrumStore.scrums)
            .task {
                await loadScrums()
            }
            .onChange(of: scenePhase) {
                saveScrums()
            }
            .sheet(item: $errorWrapper) {
                scrumStore.scrums = SampleData.scrums
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
    
    private func loadScrums() async {
        do {
            try await scrumStore.load()
        } catch {
            errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
        }
    }
    
    private func saveScrums() {
        Task {
            do {
                if (scenePhase == .inactive) {
                    try await scrumStore.save()
                }
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
            }
        }
    }
}
