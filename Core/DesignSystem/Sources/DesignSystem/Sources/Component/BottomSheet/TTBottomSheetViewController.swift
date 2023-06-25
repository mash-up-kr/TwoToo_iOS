//
//  TTBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import UIKit
import FloatingPanel

public protocol ScrollableViewController where Self: UIViewController {
    var scrollView: UIScrollView { get }
}

final public class TTBottomSheetViewController: FloatingPanelController {
    
    private let appearence: SurfaceAppearance = {
        let v = SurfaceAppearance()
        v.cornerRadius = 20
        v.backgroundColor = .second02
        v.borderColor = .clear
        v.borderWidth = 0
        return v
    }()
    
    public init(contentViewController: ScrollableViewController) {
        super.init(delegate: nil)
        super.set(contentViewController: contentViewController)
        super.track(scrollView: contentViewController.scrollView)
        
        self.setUpSurfaceView(super.surfaceView)
        self.setUpBackDropView(super.backdropView)
        self.setUpView(contentViewController: contentViewController)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(contentViewController: ScrollableViewController) {
        super.set(contentViewController: contentViewController)
        super.track(scrollView: contentViewController.scrollView)
        super.layout = TouchBlockIntrinsicPanelLayout()
    }
    
    private func setUpSurfaceView(_ surfaceView: SurfaceView) {
        surfaceView.grabberHandle.isHidden = false
        surfaceView.grabberHandle.backgroundColor = .grey400
        surfaceView.grabberHandleSize = .init(width: 39, height: 5)
        surfaceView.appearance = appearence
        // TODO: grabberHandle 위치 약간 내리기
    }
    
    private func setUpBackDropView(_ backDropView: BackdropView) {
        backdropView.dismissalTapGestureRecognizer.isEnabled = true
        backdropView.backgroundColor = .black
    }
}

extension TTBottomSheetViewController: FloatingPanelControllerDelegate {
    
    public func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        let loc = fpc.surfaceLocation
        let minY = fpc.surfaceLocation(for: .full).y
        let maxY = fpc.surfaceLocation(for: .tip).y
        let y = min(max(loc.y, minY), maxY)
        fpc.surfaceLocation = CGPoint(x: loc.x, y: y)
    }
    
    /// 특정 속도로 아래로 당겼을때 dismiss 되도록 처리됩니다.
    public func floatingPanelWillEndDragging(_ fpc: FloatingPanelController,
                                             withVelocity velocity: CGPoint,
                                             targetState: UnsafeMutablePointer<FloatingPanelState>) {
        guard velocity.y > 50 else { return }
        self.dismiss(animated: true)
    }
    
}
