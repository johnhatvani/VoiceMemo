//
//  DarkTheme.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import UIKit

struct DarkTheme: Themeable {
    var titleColor: UIColor { return UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.00) }
    var subtitleColor: UIColor { return UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1.00) }
    var primaryBackground: UIColor { return UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00) }
    var cellBackground: UIColor { return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00) }
}
