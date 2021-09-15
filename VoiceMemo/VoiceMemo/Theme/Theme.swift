//
//  Theme.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import Foundation
import UIKit

/// themeable protocol.
protocol Themeable {
    var titleColor: UIColor { get }
    var subtitleColor: UIColor { get }
    var primaryBackground: UIColor { get }
    var cellBackground: UIColor { get }
}

/// theme enum
enum Theme {
    /// Dark theme
    case dark
}

extension Theme {
    /// get the Themeable object
    var theme: Themeable {
        switch self {
        case .dark: return DarkTheme()
        }
    }
}


// MARK: - Theme allow for global access to theme.

fileprivate var AppTheme: Theme = .dark

/// Sets the global theme to the Theme supplied.
func setTheme(_ theme: Theme) {
    AppTheme = theme
}

/// Gets the global Themeable obejct
func getTheme() -> Themeable {
    return AppTheme.theme
};

/// Applies the theme vua UIAppearance protocol
func applyTheme() {
    let theme = getTheme()
    
    UINavigationBar.appearance().backgroundColor = theme.primaryBackground
    UINavigationBar.appearance().barStyle = .black
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: theme.titleColor]
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: theme.titleColor]
}
