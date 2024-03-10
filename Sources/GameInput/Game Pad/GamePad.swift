import Foundation
import GameController

public class GamePad {

    public let type: GamePadType

    /// Cast to GCController from the GameController network
    public var underlyingController: Any? {
        controller
    }

    private weak var controller: GCController?

    internal init(_ controller: GCController) {
        self.controller = controller
        type = controller.gamePadType
    }

    public func onPressChange(_ button: GamePadButton, _ handler: @escaping (Bool) -> Void) {
        button.element(of: controller)?.pressedChangedHandler = { _, _, isPressed in
            handler(isPressed)
        }
    }

    public func removeOnPressChange(for button: GamePadButton) {
        button.element(of: controller)?.pressedChangedHandler = nil
    }

    public func onValueChange(_ button: AnalogGamePadButton, _ handler: @escaping (Float, _ isPressed: Bool) -> Void) {
        button.element(of: controller)?.valueChangedHandler = { _, value, isPressed in
            handler(value, isPressed)
        }
    }

    public func removeOnValueChange(for button: AnalogGamePadButton) {
        button.element(of: controller)?.valueChangedHandler = nil
    }

    public func poll() -> GamePadSnapshot {
        var snapshot = GamePadSnapshot()

        guard let profile = controller?.physicalInputProfile else {
            return snapshot
        }

        for (name, element) in profile.elements {
            if let button = element as? GCControllerButtonInput, button.isPressed {
                switch name {
                case GCInputButtonA: snapshot.a = true
                case GCInputButtonB: snapshot.b = true
                case GCInputButtonX: snapshot.x = true
                case GCInputButtonY: snapshot.y = true

                case GCInputLeftShoulder: snapshot.leftShoulder = true
                case GCInputRightShoulder: snapshot.rightShoulder = true

                case GCInputLeftTrigger:
                    snapshot.leftTrigger = true
                    snapshot.leftAnalogTrigger = button.value
                case GCInputRightTrigger:
                    snapshot.rightTrigger = true
                    snapshot.rightAnalogTrigger = button.value

                case GCInputButtonHome: snapshot.home = true
                case GCInputButtonMenu: snapshot.menu = true
                case GCInputButtonOptions: snapshot.options = true
                case GCInputButtonShare: snapshot.share = true

                case GCInputLeftThumbstickButton: snapshot.leftStick = true
                case GCInputRightThumbstickButton: snapshot.rightStick = true

                case GCInputXboxPaddleOne: snapshot.paddle1 = true
                case GCInputXboxPaddleTwo: snapshot.paddle2 = true
                case GCInputXboxPaddleThree: snapshot.paddle3 = true
                case GCInputXboxPaddleFour: snapshot.paddle4 = true

                case GCInputDualShockTouchpadButton: snapshot.touchpad = true

                default:
                    break
                }
            } else if let stick = element as? GCControllerDirectionPad {
                let x = stick.xAxis.value
                let y = stick.yAxis.value
                let up = stick.up.isPressed
                let down = stick.down.isPressed
                let left = stick.left.isPressed
                let right = stick.right.isPressed
                switch name {
                case GCInputDirectionalDpad,
                    GCInputMicroGamepadDpad,
                    GCInputDirectionPad,
                GCInputDirectionalCardinalDpad:
                    snapshot.dPadX = x
                    snapshot.dPadY = y
                    snapshot.up = up
                    snapshot.down = down
                    snapshot.left = left
                    snapshot.right = right
                case GCInputLeftThumbstick:
                    snapshot.leftStickX = x
                    snapshot.leftStickY = y
                    snapshot.leftStickUp = up
                    snapshot.leftStickDown = down
                    snapshot.leftStickLeft = left
                    snapshot.leftStickRight = right
                case GCInputRightThumbstick:
                    snapshot.rightStickX = x
                    snapshot.rightStickY = y
                    snapshot.rightStickUp = up
                    snapshot.rightStickDown = down
                    snapshot.rightStickLeft = left
                    snapshot.rightStickRight = right
                case GCInputDualShockTouchpadOne:
                    snapshot.primaryFingerX = x
                    snapshot.primaryFingerY = y
                    snapshot.primaryFingerUp = up
                    snapshot.primaryFingerDown = down
                    snapshot.primaryFingerLeft = left
                    snapshot.primaryFingerRight = right
                case GCInputDualShockTouchpadTwo:
                    snapshot.secondaryFingerX = x
                    snapshot.secondaryFingerY = y
                    snapshot.secondaryFingerUp = up
                    snapshot.secondaryFingerDown = down
                    snapshot.secondaryFingerLeft = left
                    snapshot.secondaryFingerRight = right
                default:
                    break
                }
            }
        }

        return snapshot
    }
}

// MARK: - GCController+GamePadType

fileprivate extension GCController {

    var gamePadType: GamePadType {
        switch physicalInputProfile {
        case is GCDualSenseGamepad: .dualSense
        case is GCDualShockGamepad: .dualShock
        case is GCXboxGamepad: .xbox
        case is GCExtendedGamepad: .extended
        case is GCMicroGamepad: .micro
        case is GCDirectionalGamepad: .directional
        default: .unknown
        }
    }
}

// MARK: - GCController+Reset

extension GCController {

    fileprivate func reset() {
        let profile = physicalInputProfile
        for element in profile.allElements {
            switch element {
            case let button as GCControllerButtonInput:
                button.pressedChangedHandler = nil
                button.valueChangedHandler = nil
            case let pad as GCControllerDirectionPad:
                pad.xAxis.valueChangedHandler = nil
                pad.yAxis.valueChangedHandler = nil
                pad.up.pressedChangedHandler = nil
                pad.up.valueChangedHandler = nil
                pad.down.pressedChangedHandler = nil
                pad.down.valueChangedHandler = nil
                pad.left.pressedChangedHandler = nil
                pad.left.valueChangedHandler = nil
                pad.right.pressedChangedHandler = nil
                pad.right.valueChangedHandler = nil
            default:
                break
            }
        }
    }
}

// MARK: - GamePadButton+Element

extension GamePadButton {
    internal func element(of controller: GCController?) -> GCControllerButtonInput? {
        guard let profile = controller?.physicalInputProfile else {
            return nil
        }
        return switch self {
        case .a: profile.buttons[GCInputButtonA]
        case .b: profile.buttons[GCInputButtonB]
        case .x: profile.buttons[GCInputButtonX]
        case .y: profile.buttons[GCInputButtonY]
        case .leftShoulder: profile.buttons[GCInputLeftShoulder]
        case .rightShoulder: profile.buttons[GCInputRightShoulder]
        case .leftTrigger: profile.buttons[GCInputLeftTrigger]
        case .rightTrigger: profile.buttons[GCInputRightTrigger]
        case .home: profile.buttons[GCInputButtonHome]
        case .menu: profile.buttons[GCInputButtonMenu]
        case .options: profile.buttons[GCInputButtonOptions]
        case .share: profile.buttons[GCInputButtonShare]
        case .up: profile.dpads[GCInputDirectionPad]?.up
        case .down: profile.dpads[GCInputDirectionPad]?.down
        case .left: profile.dpads[GCInputDirectionPad]?.left
        case .right: profile.dpads[GCInputDirectionPad]?.right
        case .leftStick: profile.buttons[GCInputLeftThumbstickButton]
        case .rightStick: profile.buttons[GCInputRightThumbstickButton]
        case .leftStickUp: profile.dpads[GCInputLeftThumbstick]?.up
        case .leftStickDown: profile.dpads[GCInputLeftThumbstick]?.down
        case .leftStickLeft: profile.dpads[GCInputLeftThumbstick]?.right
        case .leftStickRight: profile.dpads[GCInputLeftThumbstick]?.left
        case .rightStickUp: profile.dpads[GCInputRightThumbstick]?.up
        case .rightStickDown: profile.dpads[GCInputRightThumbstick]?.down
        case .rightStickLeft: profile.dpads[GCInputRightThumbstick]?.left
        case .rightStickRight: profile.dpads[GCInputRightThumbstick]?.right
        case .paddle1: profile.buttons[GCInputXboxPaddleOne]
        case .paddle2: profile.buttons[GCInputXboxPaddleTwo]
        case .paddle3: profile.buttons[GCInputXboxPaddleThree]
        case .paddle4: profile.buttons[GCInputXboxPaddleFour]
        case .touchpad: profile.buttons[GCInputDualShockTouchpadButton]
        case .primaryFingerUp: profile.dpads[GCInputDualShockTouchpadOne]?.up
        case .primaryFingerDown: profile.dpads[GCInputDualShockTouchpadOne]?.down
        case .primaryFingerLeft: profile.dpads[GCInputDualShockTouchpadOne]?.left
        case .primaryFingerRight: profile.dpads[GCInputDualShockTouchpadOne]?.right
        case .secondaryFingerUp: profile.dpads[GCInputDualShockTouchpadTwo]?.up
        case .secondaryFingerDown: profile.dpads[GCInputDualShockTouchpadTwo]?.down
        case .secondaryFingerLeft: profile.dpads[GCInputDualShockTouchpadTwo]?.left
        case .secondaryFingerRight: profile.dpads[GCInputDualShockTouchpadTwo]?.right
        }
    }
}

// MARK: - AnalogGamePadButton+Element

extension AnalogGamePadButton {
    internal func element(of controller: GCController?) -> GCControllerButtonInput? {
        guard let profile = controller?.physicalInputProfile else {
            return nil
        }
        return switch self {
        case .leftTrigger: profile.buttons[GCInputLeftTrigger]
        case .rightTrigger: profile.buttons[GCInputRightTrigger]
        }
    }
}
