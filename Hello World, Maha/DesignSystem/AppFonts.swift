import SwiftUI

extension Font {
    static let display        = Font.system(size: 42, weight: .black)     // Journali
    static let headingL       = Font.system(size: 34, weight: .bold)      // عنوان Journal
    static let headingM       = Font.system(size: 24, weight: .bold)      // Begin Your Journal
    static let titleCard      = Font.system(size: 24, weight: .semibold)  // عنوان الكرت
    static let bodyL          = Font.system(size: 20, weight: .regular)
    static let bodyM          = Font.system(size: 18, weight: .regular)   // نص اليومية
    static let bodySupporting = Font.system(size: 18, weight: .light)     // الجمل التوضيحية
    static let captionM       = Font.system(size: 16, weight: .regular)
    static let captionS       = Font.system(size: 14, weight: .regular)   // التاريخ
}
