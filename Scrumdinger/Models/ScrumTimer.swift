/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation

/// Keeps time for a daily scrum meeting. Keep track of the total meeting time, the time for each speaker, and the name of the current speaker.

@MainActor
@Observable
final class ScrumTimer {
    /// A struct to keep track of meeting attendees during a meeting.
    struct Speaker: Identifiable {
        /// The attendee name.
        let name: String
        /// True if the attendee has completed their turn to speak.
        var isCompleted: Bool
        /// Id for Identifiable conformance.
        let id = UUID()
    }
    
    var totalSeconds: Int {
        lengthInSeconds
    }
    
    var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    /// The name of the meeting attendee who is speaking.
    var activeSpeakerName: String {
        speakers.isEmpty ? "" : speakers[speakerIndex].name
    }
    
    /// The number of the meeting attendee who is speaking
    var acriveSpeakerNumber: Int {
        speakerIndex + 1
    }
    
    /// True if current speaker is last for this scrum
    var isLastSpeaker: Bool {
        speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    /// The number of seconds since the beginning of the meeting.
    var secondsElapsed = 0
    /// The number of seconds until all attendees have had a turn to speak.
    var secondsRemaining = 0

    /// A closure that is executed when a new attendee begins speaking.
    var speakerChangedAction: (() -> Void)?

    /// All meeting attendees, listed in the order they will speak.
    private(set) var speakers: [Speaker] = []
    /// The scrum meeting length.
    private(set) var lengthInMinutes: Int
    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var startDate: Date?
    
    /**
     Initialize a new timer. Initializing a time with no arguments creates a ScrumTimer with no attendees and zero length.
     Use `startScrum()` to start the timer.
     
     - Parameters:
        - lengthInMinutes: The meeting length.
        -  attendees: A list of attendees for the meeting.
     */
    init(lengthInMinutes: Int = 0, speakers: [Speaker] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = speakers
        secondsRemaining = lengthInSeconds
    }
    
    /// Start the timer.
    func startScrum() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    /// Stop the timer.
    func stopScrum() {
        timer?.invalidate()
        timerStopped = true
    }
    
    /// Advance the timer to the next speaker.
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }

    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForSpeaker = 0
        guard index < speakers.count else { return }
        speakerIndex = index

        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
    }

    nonisolated private func update() {

        Task { @MainActor in
            guard let startDate,
                  !timerStopped else { return }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForSpeaker = secondsElapsed
            self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
            guard secondsElapsed <= secondsPerSpeaker else {
                return
            }
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangedAction?()
            }
        }
    }
    
    /**
     Reset the timer with a new meeting length and new attendees.
     
     - Parameters:
         - lengthInMinutes: The meeting length.
         - attendees: The name of each attendee.
     */
    func reset(lengthInMinutes: Int = 0, speakers: [Speaker] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = speakers
        secondsRemaining = lengthInSeconds
    }
}

extension DailyScrum {
    var speakers: [ScrumTimer.Speaker] {
        return availableAttendees
            .map {
                ScrumTimer.Speaker(name: $0.name, isCompleted: false)
            }
    }
}
