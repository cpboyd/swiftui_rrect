//
//  image.swift
//  rrect
//
//  Created by Christopher Boyd on 10/13/21.
//

import Foundation
import SwiftUI

extension View {
    @inlinable public func hosted(width: CGFloat, height: CGFloat, alignment: Alignment = .center, backgroundColor: UIColor? = .clear) -> UIViewController {
        let size = CGSize(width: width, height: height)
        
        let controller = UIHostingController(rootView: self.freeFrame(width: width, height: height, alignment: alignment))
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.backgroundColor = backgroundColor
        return controller
    }
    
    @inlinable public func freeFrame(width: CGFloat, height: CGFloat, alignment: Alignment = .center) -> some View {
        return  self.ignoresSafeArea().frame(width: width, height: height, alignment: alignment);
    }
    
    func saveAsImage(width: CGFloat, height: CGFloat, alignment: Alignment = .center, backgroundColor: UIColor? = .clear, _ completion: @escaping (UIImage?) -> Void) {
        let controller = self.hosted(width: width, height: height, alignment: alignment, backgroundColor: backgroundColor)
        let image = controller.view.asImage()
        
        completion(image)
    }
    
    func snapshot(width: CGFloat, height: CGFloat, alignment: Alignment = .center, backgroundColor: UIColor? = .clear) -> UIImage? {
        let controller = self.hosted(width: width, height: height, alignment: alignment, backgroundColor: backgroundColor)
        return controller.view.asImage()
    }
}

extension UIView {
    func asImage() -> UIImage? {
        var didDraw = false
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let png = renderer.pngData { ctx in
            didDraw = self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        if (!didDraw) {
            return nil
        }
        return UIImage(data: png)
    }
}
