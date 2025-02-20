//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 19.02.2025.
//

import SwiftUI

struct MeetingTimerView: View {
    let scrumTimer: ScrumTimer
    let theme: Theme
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(scrumTimer.activeSpeakerName)
                        .font(.title)
                    Text("is speaking")
                }
                .foregroundStyle(theme.accentColor)
                .accessibilityElement(children: .combine)
            }
            .overlay {
                ForEach(scrumTimer.speakers.indices, id: \.self) { index in
                    if scrumTimer.speakers[index].isCompleted {
                        SpeakerArc(speakerIndex: index, totalSpeakers: scrumTimer.speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

#Preview {
    let speakers: [ScrumTimer.Speaker] = [
        ScrumTimer.Speaker(name: "Bill", isCompleted: true),
        ScrumTimer.Speaker(name: "Cathy", isCompleted: false),
        ScrumTimer.Speaker(name: "Sandy", isCompleted: false),
        ScrumTimer.Speaker(name: "Michael", isCompleted: false)
    ]
    
    let scrumTimer = ScrumTimer(lengthInMinutes: 10, speakers: speakers)
    
    MeetingTimerView(scrumTimer: scrumTimer, theme: .orange)
}
