//
//  NaviBar.swift
//  
//
//  Created by Дмитрий Папков on 15.09.2021.
//

import SwiftUI

public struct NaviBar<Leading, Back, Trailing, Content, Background>: View where Leading: View, Trailing: View, Content: View, Background: View, Back: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.naviView) var navi
    
    var content: Content
    var back: Back?
    var leading: Leading
    var trailing: Trailing
    var bg: Background
    var placement: NaviBarPlacement = .page
    var style: NaviBarStyle
    
    init(
        content: Content,
        leading: Leading,
        back: Back? = nil,
        trailing: Trailing,
        background: Background,
        placement: NaviBarPlacement,
        style: NaviBarStyle = .always
    ) {
        self.content = content
        self.leading = leading
        self.back = back
        self.trailing = trailing
        self.bg = background
        self.placement = placement
        self.style = style
    }
    
    public var body: some View {
        GeometryReader { g in
            content
                .font(.headline)
                .padding(.vertical, 12)
                .opacity(style.opacity(proxy: g))
                .frame(maxWidth: .infinity)
                .overlay(leadingView, alignment: .leading)
                .overlay(trailing, alignment: .trailing)
                .frame(height: 38)
                .padding(.horizontal)
                .frame(height: 38 + style.safeArea.top + style.topSizeble(g), alignment: .bottom)
                .background(bg.opacity(style.opacity(proxy: g)))
                .offset(y: style.fixedTop(g) - style.safeArea.top - style.topSizeble(g))
        }
        .zIndex(1)
        .frame(height: 38)
    }
    
    var leadingView: some View {
        HStack {
            if let back = back {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) { back }
            }
                
            leading
        }
    }
}

public enum NaviBarPlacement {
    case page
    case scroll
}

public enum NaviBarStyle {
    case always
    case appear(after: CGFloat, percent: CGFloat = 0.5)

    var safeArea: UIEdgeInsets {
        UIApplication.shared.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets ?? .zero
    }
    
    func opacity(proxy: GeometryProxy) -> Double {
        switch self {
        case .always:
            return 1
        case .appear(after: let offset, percent: let percent):
            let proxyValue = fixedTop(proxy) - topSizeble(proxy)
            let halfOffset = offset * percent
            
            guard proxyValue > halfOffset else { return 0 }
            
            let divider = proxyValue - halfOffset
            
            let opacity = divider / halfOffset
            
            return opacity < 1 ? Double(opacity) : 1
        }
    }
    
    func fixedTop(_ geo: GeometryProxy) -> CGFloat {
        geo.frame(in: .global).minY < safeArea.top ? -geo.frame(in: .global).minY + safeArea.top : 0
    }
    
    func topSizeble(_ geo: GeometryProxy) -> CGFloat {
        geo.frame(in: .global).minY > safeArea.top ? geo.frame(in: .global).minY - safeArea.top : 0
    }
}
