//  Created by Sergey Chsherbak on 14/04/2023.

import Foundation

public struct ToastConfiguration {
    
    /// Boolean value that determines whether a toast can be hidden on its own after specified `displayDuration`.
    public let isAutohidable: Bool
    
    /// The duration for displaying a toast.
    public var displayDuration: TimeInterval
    
    /// The duration of animation.
    public let animationDuration: TimeInterval
    
    /// Boolean value that determines whether it is possible to interact with a toast.
    public let isUserInteractionEnabled: Bool
    
    /// The type of the animation.
    public let animationType: AnimationType
    
    public enum AnimationType {
        case top
    }
    
    public init(
        isAutohidable: Bool,
        displayDuration: TimeInterval,
        animationDuration: TimeInterval,
        isUserInteractionEnabled: Bool,
        animationType: AnimationType
    ) {
        self.isAutohidable = isAutohidable
        self.displayDuration = displayDuration
        self.animationDuration = animationDuration
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.animationType = animationType
    }
}
