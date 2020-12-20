import Foundation

/// Represents an individual Account held within an Institution Client (e.g. a Netbank Saver Account)
struct Account {
    let label: String
    let income: Decimal
    let spendAmount: Decimal
    var balance: Decimal {
        income - spendAmount
    }
}
