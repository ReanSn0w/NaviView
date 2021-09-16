//
//  Environment.swift
//  
//
//  Created by Дмитрий Папков on 15.09.2021.
//

import SwiftUI

public struct NaviViewEnvironmentKey: EnvironmentKey {
    public static let defaultValue: NaviViewEnvPass = .init()
}

extension EnvironmentValues {
    public var naviView: NaviViewEnvPass {
        get { self[NaviViewEnvironmentKey.self] }
        set { self[NaviViewEnvironmentKey.self] = newValue }
    }
}

public class NaviViewEnvPass {
    private(set) public var navigationController: UINavigationController? = nil
    
    func set(navigation viewController: UINavigationController) {
        self.navigationController = viewController
    }
}

extension NaviViewEnvPass {
    /// последний view controller из navigation stack
    public var lastViewController: UIViewController? {
        navigationController?.viewControllers.last
    }
    
    /// исключение верхнего view controller'а из стека
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    /// добавление swiftui view в navigation stack
    func push<Content: View>(animated: Bool, @ViewBuilder content: () -> Content) {
        navigationController?.pushViewController(UIHostingController(rootView: content()), animated: animated)
    }
}
