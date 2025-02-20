//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 30.01.2025.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    
    private let player = AVPlayer.sharedDingPlayer
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(scrumTimer: scrumTimer, theme: scrum.theme)
                MeetingTimerView(scrumTimer: scrumTimer, theme: scrum.theme)
                MeetingFooterView(scrumTimer: scrumTimer)
            }
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
    }
    
    private func startScrum() {
        scrumTimer.reset(
            lengthInMinutes: scrum.lengthInMinutes,
            speakers: scrum.speakers)
        scrumTimer.startScrum()
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        scrum.updateHistory()
    }
}

#Preview {
    MeetingView(scrum: .constant(SampleData.scrums[0]))
}
