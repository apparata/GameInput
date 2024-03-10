import Foundation
import GameController

// MARK: - GameInput

public class GameInput {

    public private(set) var currentGamePad: GamePad?

    public var onDidBecomeCurrentGamePad: ((GamePad) -> Void)?
    public var onDidStopBeingCurrentGamePad: ((GamePad) -> Void)?

    public init() {
        if let gameController = GCController.current {
            currentGamePad = GamePad(gameController)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(controllerDidBecomeCurrent),
            name: .GCControllerDidBecomeCurrent,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(controllerDidStopBeingCurrent),
            name: .GCControllerDidStopBeingCurrent,
            object: nil
        )
    }

    // MARK: Gamepad Became Current

    @objc
    private func controllerDidBecomeCurrent(_ notification: Notification) {
        guard let gameController = notification.object as? GCController else {
            return
        }
        currentGamePad = GamePad(gameController)
    }

    // MARK: Gamepad Not Current

    @objc
    private func controllerDidStopBeingCurrent(_ notification: Notification) {
        currentGamePad = nil
    }
}
