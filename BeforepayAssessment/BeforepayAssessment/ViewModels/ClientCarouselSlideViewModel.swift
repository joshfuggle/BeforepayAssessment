import Foundation

/// View model concretion to present a list of Client Accounts in a Carousel Slide
final class ClientCarouselSlideViewModel {
    let client: Client
    var expanded: Bool
    
    init(client: Client) {
        self.client = client
        self.expanded = false
    }
}

// MARK: CarouselSlideViewModelProtocol Conformance

extension ClientCarouselSlideViewModel: CarouselSlideViewModelProtocol {
    var slideTitle: String? {
        client.institution.name
    }
    
    var cellViewModels: [CarouselSlideCellViewModelProtocol] {
        let clientVMs = client.accounts.map({
            AccountSlideCellViewModel(
                account: $0,
                groupTotalBalance: client.totalBalance,
                lastUpdated: client.lastUpdated
            )
        })
        let summaryVM = ClientSummarySlideCellViewModel(
            client: client,
            groupTotalIncome: client.totalBalance
        )
        return [summaryVM] + clientVMs
    }
    
    var customTheme: Theme? {
        nil
    }
}
