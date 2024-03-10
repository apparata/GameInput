import Foundation

public enum GamePadButton {

    // MARK: Face Buttons

    case a             // 􀀅 or 􀁡
    case b             // 􀀇 or 􀨂
    case x             // 􀀳 or 􀨄
    case y             // 􀀵 or 􀨆

    // MARK: Shoulder Buttons

    case leftShoulder  // 􀨔 or 􀨊
    case rightShoulder // 􀨖 or 􀨐

    // MARK: Trigger Buttons

    case leftTrigger   // 􀨘 or 􀨌
    case rightTrigger  // 􀨚 or 􀨒

    // MARK: Misc Buttons

    case home
    case menu
    case options
    case share         // (Xbox)

    // MARK: DPad Buttons

    case up            // 􀧾
    case down          // 􀨀
    case left          // 􀧽
    case right         // 􀧿

    // MARK: Stick Buttons

    case leftStick     // 􀫃
    case rightStick    // 􀫄

    // MARK: Left Stick Direction Buttons

    case leftStickUp
    case leftStickDown
    case leftStickLeft
    case leftStickRight

    // MARK: Right Stick Direction Buttons

    case rightStickUp
    case rightStickDown
    case rightStickLeft
    case rightStickRight

    // MARK: Paddle Buttons (Xbox)

    case paddle1
    case paddle2
    case paddle3
    case paddle4

    // MARK: Touchpad Button (PS)

    case touchpad

    // MARK: Touchpad Primary Button (PS)

    case primaryFingerUp
    case primaryFingerDown
    case primaryFingerLeft
    case primaryFingerRight

    case secondaryFingerUp
    case secondaryFingerDown
    case secondaryFingerLeft
    case secondaryFingerRight
}
