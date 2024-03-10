import Foundation

public struct GamePadSnapshot {

    // MARK: Face Buttons

    public var a: Bool = false                   // 􀀅 or 􀁡
    public var b: Bool = false                   // 􀀇 or 􀨂
    public var x: Bool = false                   // 􀀳 or 􀨄
    public var y: Bool = false                   // 􀀵 or 􀨆

    // MARK: Shoulder Buttons

    public var leftShoulder: Bool = false        // 􀨔 or 􀨊
    public var rightShoulder: Bool = false       // 􀨖 or 􀨐

    // MARK: Trigger Buttons

    public var leftTrigger: Bool = false         // 􀨘 or 􀨌
    public var rightTrigger: Bool = false        // 􀨚 or 􀨒

    // MARK: Analog Trigger Buttons

    public var leftAnalogTrigger: Float = 0      // 􀨘 or 􀨌
    public var rightAnalogTrigger: Float = 0     // 􀨚 or 􀨒

    // MARK: Misc Buttons

    public var home: Bool = false
    public var menu: Bool = false
    public var options: Bool = false
    public var share: Bool = false               // (Xbox)

    // MARK: DPad Buttons

    public var up: Bool = false                  // 􀧾
    public var down: Bool = false                // 􀨀
    public var left: Bool = false                // 􀧽
    public var right: Bool = false               // 􀧿

    // MARK: Stick Buttons

    public var leftStick: Bool = false           // 􀫃
    public var rightStick: Bool = false          // 􀫄

    // MARK: Left Stick Direction Buttons

    public var leftStickUp: Bool = false
    public var leftStickDown: Bool = false
    public var leftStickLeft: Bool = false
    public var leftStickRight: Bool = false

    // MARK: Right Stick Direction Buttons

    public var rightStickUp: Bool = false
    public var rightStickDown: Bool = false
    public var rightStickLeft: Bool = false
    public var rightStickRight: Bool = false

    // MARK: Paddle Buttons (Xbox)

    public var paddle1: Bool = false
    public var paddle2: Bool = false
    public var paddle3: Bool = false
    public var paddle4: Bool = false

    // MARK: Touchpad Button (PS)

    public var touchpad: Bool = false

    // MARK: Touchpad Primary Button (PS)

    public var primaryFingerUp: Bool = false
    public var primaryFingerDown: Bool = false
    public var primaryFingerLeft: Bool = false
    public var primaryFingerRight: Bool = false

    public var secondaryFingerUp: Bool = false
    public var secondaryFingerDown: Bool = false
    public var secondaryFingerLeft: Bool = false
    public var secondaryFingerRight: Bool = false

    // MARK: DPad

    public var dPadX: Float = 0
    public var dPadY: Float = 0

    // MARK: Left Stick

    public var leftStickX: Float = 0
    public var leftStickY: Float = 0

    // MARK: Right Stick

    public var rightStickX: Float = 0
    public var rightStickY: Float = 0

    // MARK: Touchpad Primary Finger

    public var primaryFingerX: Float = 0
    public var primaryFingerY: Float = 0

    // MARK: Touchpad Secondary Finger

    public var secondaryFingerX: Float = 0
    public var secondaryFingerY: Float = 0

    public init() {
        //
    }

    public func isPressed(_ button: GamePadButton) -> Bool {
        switch button {
        case .a: a
        case .b: b
        case .x: x
        case .y: y
        case .leftShoulder: leftShoulder
        case .rightShoulder: rightShoulder
        case .leftTrigger: leftTrigger
        case .rightTrigger: rightTrigger
        case .home: home
        case .menu: menu
        case .options: options
        case .share: share
        case .up: up
        case .down: down
        case .left: left
        case .right: right
        case .leftStick: leftStick
        case .rightStick: rightStick
        case .leftStickUp: leftStickUp
        case .leftStickDown: leftStickDown
        case .leftStickLeft: leftStickLeft
        case .leftStickRight: leftStickRight
        case .rightStickUp: rightStickUp
        case .rightStickDown: rightStickDown
        case .rightStickLeft: rightStickLeft
        case .rightStickRight: rightStickRight
        case .paddle1: paddle1
        case .paddle2: paddle2
        case .paddle3: paddle3
        case .paddle4: paddle4
        case .touchpad: touchpad
        case .primaryFingerUp: primaryFingerUp
        case .primaryFingerDown: primaryFingerDown
        case .primaryFingerLeft: primaryFingerLeft
        case .primaryFingerRight: primaryFingerRight
        case .secondaryFingerUp: secondaryFingerUp
        case .secondaryFingerDown: secondaryFingerDown
        case .secondaryFingerLeft: secondaryFingerLeft
        case .secondaryFingerRight: secondaryFingerRight
        }
    }

    public func value(_ button: AnalogGamePadButton) -> Float {
        switch button {
        case .leftTrigger: leftAnalogTrigger
        case .rightTrigger: rightAnalogTrigger
        }
    }

    public func value(_ axis: GamePadAxis) -> Float {
        switch axis {
        case .dPadX: dPadX
        case .dPadY: dPadY
        case .leftStickX: leftStickX
        case .leftStickY: leftStickY
        case .rightStickX: rightStickX
        case .rightStickY: rightStickY
        case .primaryFingerX: primaryFingerX
        case .primaryFingerY: primaryFingerY
        case .secondaryFingerX: secondaryFingerX
        case .secondaryFingerY: secondaryFingerY
        }
    }
}
