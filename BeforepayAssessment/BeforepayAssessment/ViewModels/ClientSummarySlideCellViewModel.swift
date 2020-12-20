import UIKit

/// View model concretion to present a summary of Client Accounts within a Carousel Slide Cell.
final class ClientSummarySlideCellViewModel {
    let client: Client
    let groupTotalIncome: Decimal?
    
    init(client: Client, groupTotalIncome: Decimal?) {
        self.client = client
        self.groupTotalIncome = groupTotalIncome
    }
}

// MARK: CarouselSlideCellViewModelProtocol Conformance

extension ClientSummarySlideCellViewModel: CarouselSlideCellViewModelProtocol, DataFormatting {
    var displayName: String {
        client.institution.name
    }
    
    var icon: UIImage? {
        switch client.institution {
        case .commonwealthBank: return nil // todo
        case .westpac:          return nil
        }
    }
    
    var availableAmountString: String {
        formatCurrencyString(client.totalBalance) ?? "--"
    }
    
    var availableAmountDescriptionString: String? {
        "Available balance"
    }
    
    var lastUpdatedString: String? {
        formatRelativeDate(client.lastUpdated)
    }
    
    var showSpendBadges: Bool {
        true
    }
    
    var spendViewModel: AmountViewModel? {
        formatCurrencyString(client.totalSpend).map({
            .init(
                amount: $0,
                label: "Spent"
            )
        })
    }
    
    var incomeViewModel: AmountViewModel? {
        formatCurrencyString(client.totalIncome).map({
            .init(
                amount: $0,
                label: "Income"
            )
        })
    }
    
    var balanceViewModel: BalanceBarViewModel? {
        let spent = client.totalSpend / (groupTotalIncome ?? client.totalBalance)
        let income = client.totalIncome / (groupTotalIncome ?? client.totalBalance)
        return .init(
            percentSpent: CGFloat(truncating: (spent as NSNumber)),
            percentIncome: CGFloat(truncating: (income as NSNumber))
        )
    }
}
