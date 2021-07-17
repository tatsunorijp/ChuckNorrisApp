// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func buildLane() {
        desc("Building and Testing the app")
        scan()
    }
    
    func lintLane() {
        desc("SwiftLint fine comb")
        swiftlint()
    }
    
    func runAllCi() {
        buildLane()
        swiftlint()
    }
    
    // Precisa de conta developper na appstore ;(
//    func publishAppStoreLane(withOptions options:[String: String]?) {
//        desc("Publish app FireBase")
//    }
}
