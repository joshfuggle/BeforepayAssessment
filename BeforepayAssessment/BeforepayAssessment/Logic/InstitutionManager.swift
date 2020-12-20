import Foundation

/// This is a very simple Institution Manager and is not a real world example.
/// In the real world you would likely:
/// - Return a cached Client if it exists and hasn't expired
/// - Fetch a client for a given institution from a HTTP endpoint
/// - Serialse a JSON payload in to a Client object
/// - Cache the result
final class InstitutionManager {
    static let shared: InstitutionManager = .init()
    
    func client(for institution: Institution) -> Client {
        switch institution {
        case .commonwealthBank:
            let everydayAccount: Account = .init(
                label: "Everyday Smart Access",
                income: 100,
                spendAmount: 0
            )
            let saverAccount: Account = .init(
                label: "Netbank Saver",
                income: 49,
                spendAmount: 0
            )
            return .init(
                institution: .commonwealthBank,
                lastUpdated: Date(),
                accounts: [everydayAccount, saverAccount]
            )
            
        case .westpac:
            let choiceAccount: Account = .init(
                label: "Choice",
                income: 300,
                spendAmount: 12
            )
            let savingsAccount: Account = .init(
                label: "Netbank Saver",
                income: 112,
                spendAmount: 11
            )
            return .init(
                institution: .westpac,
                lastUpdated: Date(),
                accounts: [choiceAccount, savingsAccount]
            )
        }
    }
}
