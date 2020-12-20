import Foundation

enum DataFormatters {
    static let currencyFormatter: NumberFormatter = {
        let formatter: NumberFormatter = .init()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let relativeDateFormatter: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
}

protocol DataFormatting { }

extension DataFormatting {
    func formatCurrencyString(_ number: Decimal) -> String? {
        DataFormatters.currencyFormatter.string(from: number as NSNumber)
    }
    
    func formatRelativeDate(_ date: Date) -> String {
        DataFormatters.relativeDateFormatter.string(from: date)
    }
}
