import UIKit

struct MainThemeFont: Font {
    func dynamicallyScalingFont(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        return UIFontMetrics.default.scaledFont(for: font)
    }
}
