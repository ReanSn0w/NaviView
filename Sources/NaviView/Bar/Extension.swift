//
//  Extension.swift
//  
//
//  Created by Дмитрий Папков on 16.09.2021.
//

import SwiftUI

extension NaviBar where Leading == Spacer, Trailing == Spacer, Back == Spacer, Content == Spacer, Background == Color {
    public init() {
        self.back = nil
        self.leading = Spacer()
        self.trailing = Spacer()
        self.bg = Color(.secondarySystemBackground)
        self.content = Spacer()
        self.placement = .page
        self.style = .always
    }
}

extension NaviBar where Leading == Spacer, Trailing == Spacer, Back == Spacer, Content == Text, Background == Color {
    public init(title: String) {
        self.back = Spacer()
        self.leading = Spacer()
        self.trailing = Spacer()
        self.bg = Color(.secondarySystemBackground)
        self.content = Text(title)
        self.placement = .page
        self.style = .always
    }
    
    public init<Value: StringProtocol>(title: Value) {
        self.back = Spacer()
        self.leading = Spacer()
        self.trailing = Spacer()
        self.bg = Color(.secondarySystemBackground)
        self.content = Text(title)
        self.placement = .page
        self.style = .always
    }
    
    public init(_ item: Text) {
        self.back = Spacer()
        self.leading = Spacer()
        self.trailing = Spacer()
        self.bg = Color(.secondarySystemBackground)
        self.content = item
        self.placement = .page
        self.style = .always
    }
}

public extension NaviBar {
    func style(_ style: NaviBarStyle) -> NaviBar {
        NaviBar(
            content: self.content,
            leading: self.leading,
            back: self.back,
            trailing: self.trailing,
            background: self.bg,
            placement: self.placement,
            style: style)
    }
    
    func placement(_ placement: NaviBarPlacement) -> NaviBar {
        NaviBar(
            content: self.content,
            leading: self.leading,
            back: self.back,
            trailing: self.trailing,
            background: self.bg,
            placement: placement,
            style: self.style)
    }
    
    func back<Changed: View>(item: (() -> Changed)?) -> NaviBar<Leading, Changed, Trailing, Content, Background> {
        NaviBar<Leading, Changed, Trailing, Content, Background>(
            content: self.content,
            leading: self.leading,
            back: item?(),
            trailing: self.trailing,
            background: self.bg,
            placement: self.placement,
            style: self.style)
    }
    
    func leading<Changed: View>(item: () -> Changed) -> NaviBar<Changed, Back, Trailing, Content, Background> {
        NaviBar<Changed, Back, Trailing, Content, Background>(
            content: self.content,
            leading: item(),
            back: self.back,
            trailing: self.trailing,
            background: self.bg,
            placement: self.placement,
            style: self.style)
    }
    
    func trailing<Changed: View>(item: () -> Changed) -> NaviBar<Leading, Back, Changed, Content, Background> {
        NaviBar<Leading, Back, Changed, Content, Background>(
            content: self.content,
            leading: self.leading,
            back: self.back,
            trailing: item(),
            background: self.bg,
            placement: self.placement,
            style: self.style)
    }
    
    func content<Changed: View>(item: () -> Changed) -> NaviBar<Leading, Back, Trailing, Changed, Background> {
        NaviBar<Leading, Back, Trailing, Changed, Background>(
            content: item(),
            leading: self.leading,
            back: self.back,
            trailing: self.trailing,
            background: self.bg,
            placement: self.placement,
            style: self.style)
    }
    
    func naviBackground<Changed: View>(item: () -> Changed) -> NaviBar<Leading, Back, Trailing, Content, Changed> {
        NaviBar<Leading, Back, Trailing, Content, Changed>(
            content: self.content,
            leading: self.leading,
            back: self.back,
            trailing: self.trailing,
            background: item(),
            placement: self.placement,
            style: self.style)
    }
}
