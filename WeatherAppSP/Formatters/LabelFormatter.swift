import UIKit

struct LabelFormatter {

    init() {}

    // MARK: - func
    func setupLabelSizeFont(label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
    }
}
