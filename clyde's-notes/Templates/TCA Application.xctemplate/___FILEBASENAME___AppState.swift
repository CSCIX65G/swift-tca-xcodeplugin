//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Combine
import ComposableArchitecture
import SwiftUI

// MARK: - AppState
struct AppState: Equatable {
    var firstName: String = "The"
    var lastName: String = "Maker"
    var isAppReady = false
}

// MARK: - AppAction
enum AppAction {
    case setFirstName(String)
    case setLastName(String)
    case whosYourDady
    case isAppReady
}

// MARK: - AppEnvironment
struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

// MARK: - Reducer (AppState, AppAction)
let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    // typically here you provide a way to combine other sub reducers to this
    //
    //    epsCalculatorReducer.pullback(
    //      state: \.epsCalculator,
    //      action: /AppAction.epsCalculator,
    //      environment: { _ in EPSCalculatorEnvironment() }
    //    ),
    Reducer { state, action, environment in
        struct CancelId: Hashable {}

        switch action {
        case let .setFirstName(newValue):
            state.firstName = newValue
            state.isAppReady = false
            return .none

        case let .setLastName(newValue):
            state.lastName = newValue
            state.isAppReady = false
            return .none

        case .whosYourDady:
            var time: DispatchQueue.SchedulerTimeType.Stride = 1.5

            #if DEBUG
            time = 0.25
            #endif
            return Effect(value: .isAppReady)
                .debounce(id: CancelId(), for: time, scheduler: environment.mainQueue)

        case .isAppReady:
            state.isAppReady = true
            return .none
        }
    }
)

let defaultAppStore = Store(
    initialState: AppState(
        firstName: "Klajd",
        lastName: "Deda"),
    reducer: appReducer,
    environment: AppEnvironment(
        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
        uuid: UUID.init
    )
)
