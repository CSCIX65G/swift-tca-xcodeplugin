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
            return .none

        case let .setLastName(newValue):
            state.lastName = newValue
            return .none

        case .whosYourDady:
            var time: DispatchQueue.SchedulerTimeType.Stride = 1.5

            #if DEBUG
            time = 0.25
            #endif
            return Effect(value: .isAppReady)
                .debounce(id: CancelId(), for: time, scheduler: environment.mainQueue)
        }
    }
)
