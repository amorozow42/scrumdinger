//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 12.02.2025.
//

import SwiftUI

struct MeetingFooterView: View {
    let scrumTimer: ScrumTimer
    
    private var speakerText: String {
        "Speaker \(scrumTimer.acriveSpeakerNumber): \(scrumTimer.activeSpeakerName)"
    }

    var body: some View {
        VStack {
            if (scrumTimer.isLastSpeaker) {
                Text("Last Speaker")
            } else {
                HStack {
                    Text(speakerText)
                    Spacer()
                    Button(action: scrumTimer.skipSpeaker) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
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
    
    MeetingFooterView(scrumTimer: scrumTimer)

    Spacer()
}
