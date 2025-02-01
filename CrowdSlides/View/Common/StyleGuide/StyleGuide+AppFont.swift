import SwiftUI

extension StyleGuide {
    
    struct AppFont {

        static var regularFontName: String = "" {
            didSet { refreshFonts() }
        }
        static var boldFontName: String = "" { 
            didSet { refreshFonts() }
        }

        static private(set) var mainTitle: SwiftUI.Font = createFont(for: .mainTitle)
        static private(set) var introInvite: SwiftUI.Font = createFont(for: .introInvite)
        static private(set) var body: SwiftUI.Font = createFont(for: .body)
        static private(set) var story: SwiftUI.Font = createFont(for: .story)
        static private(set) var selection: SwiftUI.Font = createFont(for: .selection)
        static private(set) var selectionPrompt: SwiftUI.Font = createFont(for: .selectionPrompt)
        static private(set) var option: SwiftUI.Font = createFont(for: .option)
        static private(set) var optionVoting: SwiftUI.Font = createFont(for: .optionVoting)
        static private(set) var selectionTimer: SwiftUI.Font = createFont(for: .selectionTimer)
        static private(set) var selectedOption: SwiftUI.Font = createFont(for: .selectedOption)
        static private(set) var theEnd: SwiftUI.Font = createFont(for: .theEnd)

        
        // private
        
        private enum FontKey {
            case mainTitle
            case introInvite
            case body
            case story
            case selection
            case selectionPrompt
            case option
            case optionVoting
            case selectionTimer
            case selectedOption
            case theEnd
        }

        
        private static let fontConfig: [FontKey: (size: CGFloat, weight: Font.Weight, isBold: Bool)] = [
            .mainTitle: (60, .bold, true),
            .introInvite: (36, .bold, true),
            .body: (24, .regular, false),
            .story: (36, .regular, false),
            .selection: (48, .regular, false),
            .selectionPrompt: (30, .regular, false),
            .option: (48, .bold, true),
            .optionVoting: (20, .regular, false),
            .selectionTimer: (30, .regular, false),
            .selectedOption: (60, .bold, true),
            .theEnd: (60, .regular, false)
        ]
        

        private static func refreshFonts() {
            mainTitle = createFont(for: .mainTitle)
            introInvite = createFont(for: .introInvite)
            body = createFont(for: .body)
            story = createFont(for: .story)
            selection = createFont(for: .selection)
            selectionPrompt = createFont(for: .selectionPrompt)
            option = createFont(for: .option)
            optionVoting = createFont(for: .optionVoting)
            selectionTimer = createFont(for: .selectionTimer)
            selectedOption = createFont(for: .selectedOption)
            theEnd = createFont(for: .theEnd)
        }

        
        private static func createFont(for key: FontKey) -> SwiftUI.Font {
            guard let config = fontConfig[key] else {
                fatalError("Invalid FontKey \(key)")
            }
            let name = config.isBold ? boldFontName : regularFontName
            return font(name: name, size: config.size, weight: config.weight)
        }

        
        private static func font(name: String, size: CGFloat, weight: Font.Weight) -> SwiftUI.Font {
            if let _ = NSFont(name: name, size: size) {
                return SwiftUI.Font.custom(name, size: size)
            } else {
                return SwiftUI.Font.system(size: size, weight: weight)
            }
        }
    }
 
}

