import UIKit

/// View model concretion to present an Account within a Carousel Slide Cell
final class AccountSlideCellViewModel {
    let account: Account
    let groupTotalBalance: Decimal
    let lastUpdated: Date
    
    init(account: Account, groupTotalBalance: Decimal, lastUpdated: Date) {
        self.account = account
        self.groupTotalBalance = groupTotalBalance
        self.lastUpdated = lastUpdated
    }
}

// MARK: CarouselSlideCellViewModelProtocol Conformance

extension AccountSlideCellViewModel: CarouselSlideCellViewModelProtocol, DataFormatting {
    var displayName: String {
        account.label
    }
       
    var icon: UIImage? {
        nil
    }
   
    var availableAmountString: String {
        formatCurrencyString(account.balance) ?? "--"
    }
   
    var availableAmountDescriptionString: String? {
        nil
    }
   
    var lastUpdatedString: String? {
        nil
    }
    
    var showSpendBadges: Bool {
        false
    }
   
    var spendViewModel: AmountViewModel? {
        formatCurrencyString(account.spendAmount).map({
            .init(
                amount: $0,
                label: "Spent"
            )
        })
    }
   
    var incomeViewModel: AmountViewModel? {
        formatCurrencyString(account.income).map({
            .init(
                amount: $0,
                label: "Income"
            )
        })
    }
    
    var balanceViewModel: BalanceBarViewModel? {
        let spent = account.spendAmount / groupTotalBalance
        let income = account.income / groupTotalBalance
        return .init(
            percentSpent: CGFloat(truncating: (spent as NSNumber)),
            percentIncome: CGFloat(truncating: (income as NSNumber))
        )
    }
}
