//
//  Time.swift
//  My2048Game
//
//  Created by Renvle RS on 1/24/24.
//

import Foundation

@Observable
class Time {
    var tolSeconds: Int
    var interval: Timer?

    init(tolSeconds: Int) {
        self.tolSeconds = tolSeconds
    }

    func getString() -> String {
        let seconds = tolSeconds % 60
        let minutes = (tolSeconds / 60) % 60
        let hours = (tolSeconds / 3600)

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    func addOneSecond() {
        tolSeconds += 1
    }

    func startTiming() {
        interval = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.addOneSecond()
        }
    }

    func stopTiming() {
        interval?.invalidate()
    }

    func clearTime() {
        tolSeconds = 0
    }
}
