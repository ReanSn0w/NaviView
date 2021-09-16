//
//  NaviView.swift
//  
//
//  Created by Дмитрий Папков on 15.09.2021.
//

import SwiftUI
import Introspect

// MARK: - Example

struct NaviViewExamplePage: View {
    @Environment(\.naviView) var navi
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                NaviBar(title: "Название")
                    .back { Image(systemName: "chevron.left") }
                    .leading { Image(systemName: "circle") }
                    .style(.appear(after: 100, percent: 0.2))
                
                Text("Названиe")
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink(destination: NaviViewExamplePage()) {
                    Text("Следующая страница")
                }
                
                Text("\(navi.navigationController?.viewControllers.count ?? -1)")
                
                Button("Pop to root") { navi.navigationController?.popToRootViewController(animated: true) }
                
                Color.yellow
                    .frame(height: 1000)
            }
        }
    }
}

struct NaviViewExample_Preview: PreviewProvider {
    static var previews: some View {
        NaviView { NaviViewExamplePage() }
            //.edgesIgnoringSafeArea(.all)
    }
}

// MARK: - NaviView

public struct NaviView<Content>: View where Content: View {
    @Environment(\.naviView) var navi
    var content: Content
    
    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        NavigationView { content }
            .environment(\.naviView, navi)
            .introspectNavigationController { nav in
                nav.navigationBar.isHidden = true
                nav.navigationBar.prefersLargeTitles = false
                
                // установка связи с NavigationView для последующего взаимодействия
                navi.set(navigation: nav)
            }
    }
}
