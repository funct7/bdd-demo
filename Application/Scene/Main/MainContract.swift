//
//  MainContract.swift
//  Application
//
//  Created by josh.fn7 on 2022/06/15.
//

import Foundation
import RxSwift
import Domain

public enum MainUserAction {
    case toggleMode
    case add
    case selectItem(TodoItem.ID)
    case deleteItems
}

public enum MainMode {
    case browse
    case edit
}

public struct MainUIState {
    public internal(set) var mode: MainMode
    public internal(set) var todoItems: [TodoItem]
    /**
     - Invariant: `mode == .browse`일 경우 `nil`. `mode == .edit`일 경우 non-`nil`.
     - Invariant: `todoItems`에 존재하는 `TodoItem.ID`.
     */
    public internal(set) var selectedItemIDs: Set<TodoItem.ID>?
}

public enum MainRoute {
    case add
    case detail(TodoItem.ID)
}

public protocol MainViewModelProtocol : AnyObject {
    
    /// State stream.
    var state: Observable<MainUIState> { get }
    /// Event stream.
    var route: Observable<MainRoute> { get }
    
    func userAction(_ action: MainUserAction)
    
}

// MARK: - Extension

extension MainUserAction : Equatable { }

extension MainMode : Equatable {
    
    mutating func toggle() {
        switch self {
        case .browse: self = .edit
        case .edit: self = .browse
        }
    }
    
}

extension MainUIState : Equatable { }

public extension MainUIState {
    
    static let empty = MainUIState(mode: .browse, todoItems: [], selectedItemIDs: nil)
    
}

extension MainRoute : Equatable { }
