import UIKit

struct HabitsColor {
    static let blue = UIColor(red:41.0/255.0, green:109.0/255.0, blue:255.0/255.0, alpha:1.0)
    static let green = UIColor(red:29.0/255.0, green:179.0/255.0, blue:34.0/255.0, alpha:1.0)
    static let purple = UIColor(red:98.0/255.0, green:54.0/255.0, blue:255.0/255.0, alpha:1.0)
    static let orange = UIColor(red:255.0/255.0, green:159.0/255.0, blue:79.0/255.0, alpha:1.0)
    
    public static func getNext(_ color: UIColor) -> UIColor {
        switch color {
        case blue:
            return green
        case green:
            return purple
        case purple:
            return orange
        case orange:
            return blue
        default:
            return blue
        }
    }
}
