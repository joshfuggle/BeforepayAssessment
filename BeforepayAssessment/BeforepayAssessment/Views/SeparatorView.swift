import UIKit

final class SeparatorView: UIView {
    var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = theme.colorSeparator
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
