// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  /// OK
  internal static let acceptAction = Localized.tr("Localizable", "accept_action")
  /// Movie Mood
  internal static let appTitle = Localized.tr("Localizable", "app_title")
  /// Budget
  internal static let budget = Localized.tr("Localizable", "budget")
  /// Something went wrong.
  /// Please try again.
  internal static let defaultError = Localized.tr("Localizable", "default_error")
  /// Description
  internal static let description = Localized.tr("Localizable", "description")
  /// Error
  internal static let errorTitle = Localized.tr("Localizable", "error_title")
  /// Invalid data. Please try again later
  internal static let invalidRequestParams = Localized.tr("Localizable", "invalid_request_params")
  /// Failed to load movies
  internal static let moviesLoadFailed = Localized.tr("Localizable", "movies_load_failed")
  /// Original Title
  internal static let originalTitle = Localized.tr("Localizable", "original_title")
  /// Production Countries
  internal static let productionCountries = Localized.tr("Localizable", "productionCountries")
  /// Rating
  internal static let rating = Localized.tr("Localizable", "rating")
  /// Release Date
  internal static let releaseDate = Localized.tr("Localizable", "releaseDate")
  /// Revenue
  internal static let revenue = Localized.tr("Localizable", "revenue")
  /// Search
  internal static let searchPlaceholder = Localized.tr("Localizable", "search_placeholder")
  /// Invalid URL
  internal static let urlNotValid = Localized.tr("Localizable", "url_not_valid")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
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
