import UIKit

protocol Theme {
    
    // MARK: Sizing
    
    var sizeXs: CGFloat                     { get }
    var sizeS: CGFloat                      { get }
    var sizeM: CGFloat                      { get }
    var sizeL: CGFloat                      { get }
    var sizeXl: CGFloat                     { get }
    var sizeXxl: CGFloat                    { get }
        
    // MARK: Spacing
        
    var spacingXs: CGFloat                  { get }
    var spacingS: CGFloat                   { get }
    var spacingM: CGFloat                   { get }
    var spacingL: CGFloat                   { get }
    var spacingXl: CGFloat                  { get }
    var spacingXxl: CGFloat                 { get }
    
    // MARK: Typography
    
    var fontDetail: UIFont                  { get }
    var fontBody: UIFont                    { get }
    var fontBodyBold: UIFont                { get }
    var fontNavigation: UIFont              { get }
    var fontTitle: UIFont                   { get }
        
    // MARK: Colors
        
    var colorBackground: UIColor            { get }
    var colorBackgroundCard: UIColor        { get }
    var colorBackgroundCardAlt: UIColor     { get }
    
    var colorSeparator: UIColor             { get }
    var colorBalanceBarBackground: UIColor  { get }
    var colorShadow: UIColor                { get } // this isn't the right color, couldnt find in InVision
    var colorPageControlTint: UIColor       { get }
    var colorPageControlTintAlt: UIColor    { get }

    var colorFontPrimary: UIColor           { get }
    var colorFontSecondary: UIColor         { get }
    var colorFontTernary: UIColor           { get }
    
    var colorNavInteractive: UIColor        { get }
    
    var colorSpend: UIColor                 { get }
    var colorSpendAlt: UIColor              { get }
    var colorIncome: UIColor                { get }
    var colorIncomeAlt: UIColor             { get }
}

// MARK: Standard Theme

class StandardTheme: Theme {
    
    // MARK: Sizing
    
    var sizeXs: CGFloat                     { 4 }
    var sizeS: CGFloat                      { 8 }
    var sizeM: CGFloat                      { 12 }
    var sizeL: CGFloat                      { 16 }
    var sizeXl: CGFloat                     { 20 }
    var sizeXxl: CGFloat                    { 24 }
     
    // MARK: Spacing
     
    var spacingXs: CGFloat                  { sizeXs }
    var spacingS: CGFloat                   { sizeS }
    var spacingM: CGFloat                   { sizeM }
    var spacingL: CGFloat                   { sizeL }
    var spacingXl: CGFloat                  { sizeXl }
    var spacingXxl: CGFloat                 { sizeXxl }
     
    // MARK: Typography
     
    var fontDetail: UIFont                  { .systemFont(ofSize: 12, weight: .medium) }
    var fontBody: UIFont                    { .systemFont(ofSize: 14) }
    var fontBodyBold: UIFont                { .systemFont(ofSize: 14, weight: .bold) }
    var fontNavigation: UIFont              { .systemFont(ofSize: 18, weight: .bold) }
    var fontTitle: UIFont                   { .systemFont(ofSize: 24, weight: .heavy) }
     
    // MARK: Colors
    
    var colorBackground: UIColor            { .hexColor("#F4F3F5") }
    var colorBackgroundCard: UIColor        { .hexColor("#FFFFFF") }
    var colorBackgroundCardAlt: UIColor     { .hexColor("#EFEFEF") }
    
    var colorSeparator: UIColor             { .hexColor("#E7E7E7") }
    var colorBalanceBarBackground: UIColor  { .hexColor("#E7E7E7") }
    var colorShadow: UIColor                { .hexColor("#D9DAE1") } // this isn't the right color, couldnt find in InVision
    var colorNavInteractive: UIColor        { .black }
    var colorPageControlTint: UIColor       { .lightGray }
    var colorPageControlTintAlt: UIColor    { .gray }
    
    var colorFontPrimary: UIColor           { .hexColor("#333333") }
    var colorFontSecondary: UIColor         { .hexColor("#666666") }
    var colorFontTernary: UIColor           { .hexColor("#999999" )}
    
    var colorSpend: UIColor                 { .hexColor("#00A2DD") }
    var colorSpendAlt: UIColor              { .hexColor("#09C4AE") }
    var colorIncome: UIColor                { .hexColor("#CD3849") }
    var colorIncomeAlt: UIColor             { .hexColor("#DA6545") }
}

// MARK: BlueTheme

class BlueTheme: StandardTheme {
    override var colorBackgroundCard: UIColor       { .hexColor("#0385C2") }
    override var colorBackgroundCardAlt: UIColor    { .hexColor("#023591") }
    
    override var colorBalanceBarBackground: UIColor { UIColor.white.withAlphaComponent(0.1) }
    override var colorSeparator: UIColor            { UIColor.white.withAlphaComponent(0.25) }
     
    override var colorFontPrimary: UIColor          { .white }
    override var colorFontSecondary: UIColor        { colorFontPrimary.withAlphaComponent(0.75) }
    override var colorFontTernary: UIColor          { colorFontPrimary.withAlphaComponent(0.75) }
}

// MARK: Extension

extension UIColor {
    static func hexColor(_ hexString: String) -> UIColor {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        return UIColor(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
