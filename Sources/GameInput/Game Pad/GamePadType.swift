import Foundation

public enum GamePadType {
    case unknown
    case directional
    case micro
    case extended
    case xbox
    case dualShock
    case dualSense

    public func `is`(_ type: GamePadType) -> Bool { self == type }
    public var isMicro: Bool { self == .micro }
    public var isExtended: Bool { self == .extended }
    public var isXbox: Bool { self == .xbox }
    public var isPlayStation: Bool { isDualSense || isDualShock }
    public var isDualShock: Bool { self == .dualShock }
    public var isDualSense: Bool { self == .dualSense }
}
