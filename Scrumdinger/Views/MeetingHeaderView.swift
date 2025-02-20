//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 11.02.2025.
//

import SwiftUI

struct MeetingHeaderView: View {
    let scrumTimer: ScrumTimer
    let theme: Theme

    var body: some View {
        VStack {
            ProgressView(value: scrumTimer.progress).progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(scrumTimer.secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(scrumTimer.secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
            .padding(.horizontal, 5)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(scrumTimer.minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview() {
    let scrumTimer = ScrumTimer(lengthInMinutes: 10, speakers: [])

    MeetingHeaderView(scrumTimer: scrumTimer, theme: .orange)

    Spacer()
}
