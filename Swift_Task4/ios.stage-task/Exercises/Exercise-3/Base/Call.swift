import Foundation

typealias CallID = UUID

struct Call {
    let id: CallID
    var incomingUser: User?
    var outgoingUser: User?
    var status: CallStatus
}

enum CallEndReason: Equatable {
    case cancel // Call was canceled before the other user answered
    case end // Call ended after successful conversation
    case userBusy // Call ended because the user is busy
    case error
}

enum CallStatus: Equatable {
    case calling
    case talk
    case ended(reason: CallEndReason)
}

