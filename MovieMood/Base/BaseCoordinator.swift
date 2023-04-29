//
//  BaseCoordinator.swift
//  MovieMood
//
//  Created by Danil Frolov on 10.04.2023.
//

import Foundation

public typealias Block<T> = (T) -> Void

/// Base class. Contains basic methods and mechanisms for implementing the concept `parent -> child`
open class BaseCoordinator<ResultType> {

    // MARK: - Public properties

    /// Called by the coordinator at the end of its `Flow`
    /// With the given callback-a
    public var onComplete: Block<ResultType>?

    // MARK: - Private properties

    /// Unique identifier of the coordinator
    private let identifier = UUID()

    /// Dictionary of `child`-coordinators.
    /// Needed to maintain the lifecycle of a `child` coordinator.
    /// Coordinators form a tree structure
    var childCoordinators: [UUID: Any] = [:]

    // MARK: - Init

    public init() {}

    // MARK: - Public methods

    /// Starts a new coordinator. Keeps a link to it from the moment it starts and releases it at the moment endings.
    /// It's important to call `super.coordinate (_ :)` when overriding a method.
    ///
    /// - Parameter coordinator: Starting Coordinator
    open func coordinate<T>(to coordinator: BaseCoordinator<T>) {
        store(coordinator: coordinator)
        let completion = coordinator.onComplete
        coordinator.onComplete = { [weak self, weak coordinator] value in
            completion?(value)
            if let coordinator = coordinator {
                self?.free(coordinator: coordinator)
            }
        }
        Task {
            await MainActor.run(body: {
                coordinator.start()
            })
        }
    }

    @MainActor
    /// Abstract method. Launches the `Flow` coordinator.
    open func start() {
        fatalError("❌ Method should be overridden")
    }

    // MARK: - Private methods

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
}
