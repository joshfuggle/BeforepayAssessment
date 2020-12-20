import Foundation

/// Represents a supported Institution (e.g. CBA)
enum Institution {
    case commonwealthBank
    case westpac
}

extension Institution {
    var name: String {
        switch self {
        case .commonwealthBank: return "Commonwealth Bank"
        case .westpac:          return "Westpac"
        }
    }
}
