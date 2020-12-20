import Foundation

/// Represents the client of a particular Institution.
struct Client {
    let institution: Institution
    let lastUpdated: Date
    let accounts: [Account]
    
    var totalBalance: Decimal {
        accounts.reduce(into: Decimal(0), { $0 = $0 + $1.balance })
    }
    
    var totalSpend: Decimal {
        accounts.reduce(into: Decimal(0), { $0 = $0 + $1.spendAmount })
    }
    
    var totalIncome: Decimal {
        accounts.reduce(into: Decimal(0), { $0 = $0 + $1.income })
    }
}
