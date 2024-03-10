
# GameInput

Simple game input for iOS, macOS, tvOS, and visionOS.

## License

This package is licensed under the BSD Zero Clause license. It does not require attribution and can be used in closed-source commercial projects. See the LICENSE file for detailed licensing information.

## Using GameInput

Below is an example how to use `GameInput` in a RealityKit `System`. Press and value change handlers can be set up for game pad buttons, but they can also be polled in the update loop.

Currently, `GameInput` only supports one game pad at a time.

```swift
import Foundation
import RealityKit
import GameInput

public final class DemoSystem: RealityKit.System {

    public let input = GameInput()

    public required init(scene: Scene) {
        input.currentGamePad?.onPressChange(.options) { isPressed in
            print("The options button is pressed.")
        }

        input.onDidBecomeCurrentGamePad = { gamePad in
            gamePad.onValueChange(.leftTrigger) { value, isPressed in
                print("The left trigger has analog value \(value).")
                if isPressed {
                    print("It is pressed.")
                }
            }
        }
    }

    public func update(context: SceneUpdateContext) {
        guard let gamePad = input.currentGamePad else { return }
        
        let snapshot = gamePad.poll()
        
        if snapshot.a {
            print("Button A is pressed.")
        }

        let xAxis = snapshot.leftStickX
        print("The left stick is horizontally at value \(xAxis)")
    }
}
```
