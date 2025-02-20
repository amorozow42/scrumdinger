//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 18.02.2025.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
    
    static var sampleWrapper: ErrorWrapper {
        enum SampleError: Error {
            case errorRequired
        }

        return ErrorWrapper(error: SampleError.errorRequired, guidance: "You can ignore this error.")
    }
}
