import Foundation

public enum L10n {
  public enum Action {
    public static let cancel = tr("action.cancel")
    public static let addPage = tr("action.page_add")
    public static let deleteNote = tr("action.note_delete")
  }
}

private extension L10n {
  static func tr(_ key: String, args: CVarArg...) -> String {
    let table = "Localizable"
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
