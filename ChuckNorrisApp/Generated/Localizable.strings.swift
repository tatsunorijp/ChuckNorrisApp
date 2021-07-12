// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum ChuckNorrisFacts {
    /// Chuck Norris Facts
    internal static let title = L10n.tr("Localizable", "ChuckNorrisFacts.Title")
    internal enum Button {
      /// More
      internal static let more = L10n.tr("Localizable", "ChuckNorrisFacts.Button.More")
    }
    internal enum EmptyView {
      /// No facts found, click on the magnifying glass above to search for something
      internal static let label = L10n.tr("Localizable", "ChuckNorrisFacts.EmptyView.Label")
    }
  }

  internal enum Error {
    /// Request not understood, please contact our providers
    internal static let badRequest = L10n.tr("Localizable", "Error.BadRequest")
    /// Access Denied, Check your connection is secure
    internal static let forbidden = L10n.tr("Localizable", "Error.Forbidden")
    /// Internal error, please, contact our providers
    internal static let internalServerError = L10n.tr("Localizable", "Error.InternalServerError")
    /// Please, check your internet connection
    internal static let noInternetAccess = L10n.tr("Localizable", "Error.NoInternetAccess")
    /// Route not found
    internal static let notFound = L10n.tr("Localizable", "Error.NotFound")
    /// Ohh nooo...
    internal static let title = L10n.tr("Localizable", "Error.Title")
    /// \nError %@, please contact our providers.
    internal static func unexpected(_ p1: Any) -> String {
      return L10n.tr("Localizable", "Error.Unexpected", String(describing: p1))
    }
  }

  internal enum SearchFacts {
    /// Search
    internal static let title = L10n.tr("Localizable", "SearchFacts.Title")
    internal enum Button {
      /// SEARCH
      internal static let search = L10n.tr("Localizable", "SearchFacts.Button.Search")
    }
    internal enum Label {
      /// Enter the search term below
      internal static let search = L10n.tr("Localizable", "SearchFacts.Label.Search")
    }
    internal enum Textfield {
      /// Ex: Axel
      internal static let placeholder = L10n.tr("Localizable", "SearchFacts.Textfield.Placeholder")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
