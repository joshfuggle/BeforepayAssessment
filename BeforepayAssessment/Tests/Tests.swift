import XCTest
@testable import BeforepayAssessment

class Tests: XCTestCase {
    
    var everydayAccount: Account!
    var cbaClient: Client!
    
    var westpacChoice: Account!
    var westpacSaver: Account!
    var westpacClient: Client!
    
    override func setUp() {
        super.setUp()
        
        // cba
        
        everydayAccount = .init(
            label: "Everyday",
            income: 1000,
            spendAmount: 200
        )
        
        cbaClient = .init(
            institution: .commonwealthBank,
            lastUpdated: Date(),
            accounts: [everydayAccount]
        )
        
        // westpac
        
        westpacChoice = .init(
            label: "Choice",
            income: 300,
            spendAmount: 100
        )
        
        westpacSaver = .init(
            label: "Saver",
            income: 1000,
            spendAmount: 400
        )
        
        westpacClient = .init(
            institution: .westpac,
            lastUpdated: Date(),
            accounts: [westpacChoice, westpacSaver]
        )
    }
    
    func testClientCarouselViewModel() throws {
        let viewModel: ClientCarouselSlideViewModel = .init(client: westpacClient)
        XCTAssertEqual(viewModel.slideTitle, "Westpac")
        
        let cellViewModels = viewModel.cellViewModels
        XCTAssertEqual(cellViewModels.count, 3)
        
        let summaryCellViewModel = cellViewModels.first!
        XCTAssertTrue(summaryCellViewModel is ClientSummarySlideCellViewModel)
    }
    
    func testAccountSlideCellViewModel() throws {
        let viewModel: AccountSlideCellViewModel = .init(
            account: everydayAccount,
            groupTotalBalance: 2000,
            lastUpdated: Date()
        )
        
        XCTAssertEqual(viewModel.displayName, "Everyday")
        XCTAssertEqual(viewModel.availableAmountString, "$800")
        
        let spendViewModel = viewModel.spendViewModel
        XCTAssertEqual(spendViewModel?.amount, "$200")
        XCTAssertEqual(spendViewModel?.label, "Spent")
        
        let balanceViewModel = viewModel.balanceViewModel
        XCTAssertEqual(balanceViewModel?.percentSpent, 0.1)
        XCTAssertEqual(balanceViewModel?.percentIncome, 0.5)
    }
    
}
