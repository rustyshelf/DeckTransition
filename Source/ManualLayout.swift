//
//  ManualLayout.swift
//  DeckTransition
//
//  Created by Harshil Shah on 13/09/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

import UIKit

/// A wrapper for a bunch of sizing methods
final class ManualLayout {
    
    /// Just a convenience method to access the height of the status bar
    class var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// The top inset of the containerView within its window based on the status
    /// bar. This exists entirely because the opaque blue location and green
    /// in-call status bars on portrait non-X iPhones inset the containerView
    /// by 20px
    class var containerViewTopInset: CGFloat {
        let statusBarHeight = ManualLayout.statusBarHeight
        
        switch statusBarHeight {
        case 0:     return 0
        case 20:    return 0
        case 40:    return 20
        case 44:    return 0
        default:    return 0
        }
    }
    
    /// The top inset of the presentingView within the containerView.
    ///
    /// The values are as follows, for a given value of the status bar:
    /// - Landscape on iPhone means the status bar is hidden, and since that
    ///   means an extremely wide aspect ratio, the inset is just 8 points
    /// - On iPads, and with the single-height status bar on portrait, non-X
    ///   iPhones, the status bar is 20px, so the view is also inset by the same
    /// - With the double-height status bar on portrait, non-X iPhones, the view
    ///   is inset by 20 points since the containerView itself is also inset by
    ///   20 points
    /// - On iPhone X in portrait, the inset is the full height of the status
    ///   bar
    class var presentingViewTopInset: CGFloat {
        let statusBarHeight = ManualLayout.statusBarHeight
        
        switch statusBarHeight {
        case 0:     return 8
        case 20:    return 20
        case 40:    return 20
        case 44:    return 44
        default:    return statusBarHeight
        }
    }
    
    /// Kinda dodgy but these methods allow us to present smaller views on the iPad
    /// Very specific to what we use this library for and probably will screw up for you if you fork this, sorry
    class func presentFrame(availableWidth: CGFloat, height: CGFloat, y: CGFloat, customLargeScreenSize: Bool) -> CGRect {
        if !customLargeScreenSize || !adjustmentsRequired(height: height, width: availableWidth) {
            return CGRect(x: 0, y: y, width: availableWidth, height: height)
        }
        
        let width = min(420, availableWidth)
        let x = (availableWidth - width) / 2.0
        
        let adjustedHeight = min(650, height)
        let adjustedY = y < 100 ? (height - adjustedHeight) / 2.0 : y
        
        return CGRect(x: x, y: adjustedY, width: width, height: adjustedHeight)
    }
    
    private class func adjustmentsRequired(height: CGFloat, width: CGFloat) -> Bool {
        return width > 500 || height > 900
    }
}
