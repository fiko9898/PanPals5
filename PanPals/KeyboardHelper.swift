//
//  KeyboardHelper.swift
//  PanPals
//
//  Created by Fiko on 15.07.2024.
//

import Foundation
import SwiftUI
import Combine

final class KeyboardHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .sink { [weak self] notification in
                self?.keyboardHeight = notification.keyboardHeight
            }
            .store(in: &cancellableSet)
    }

    deinit {
        cancellableSet.forEach { $0.cancel() }
    }
}

private extension Notification {
    var keyboardHeight: CGFloat {
        guard let userInfo = self.userInfo else { return 0 }
        let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        return self.name == UIResponder.keyboardWillHideNotification ? 0 : endFrame.height
    }
}
