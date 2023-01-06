//
//  UIView+Autolayout.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 24/09/2022.
//

import UIKit

private enum Constants {
    static let defaultConstraintPriority: Float = 999
}

extension UIView {
    @discardableResult
    func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func applyConstraint(_ constraint: NSLayoutConstraint) {
        constraint.priority = UILayoutPriority(rawValue: Constants.defaultConstraintPriority)
        constraint.isActive = true
    }

    // MARK: Size
    @discardableResult func autoSetWidth(_ width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: width)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoSetHeight(_ height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: height)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoSetSize(_ size: CGSize) -> [NSLayoutConstraint] {
        return [
            autoSetWidth(size.width),
            autoSetHeight(size.height)
        ]
    }

    // MARK: Positioning
    @discardableResult func autoSetTopSpace(_ spacing: CGFloat = 0,
                                            toView: UIView? = nil,
                                            relation: NSLayoutConstraint.Relation = .equal,
                                            useSafeAreas: Bool = false) -> NSLayoutConstraint {
        guard let superview = self.superview else { fatalError("View does not have a superview") }

        let targetView = toView ?? superview
        let constrainingToSuperView = (targetView === superview)

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: relation,
                                            toItem: useSafeAreas ? targetView.safeAreaLayoutGuide : targetView,
                                            attribute: constrainingToSuperView ? .top : .bottom,
                                            multiplier: 1.0,
                                            constant: spacing)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoSetLeftSpace(_ spacing: CGFloat = 0,
                                             toView: UIView? = nil,
                                             relation: NSLayoutConstraint.Relation = .equal,
                                             useSafeAreas: Bool = false) -> NSLayoutConstraint {
        guard let superview = self.superview else { fatalError("View does not have a superview") }

        let targetView = toView ?? superview
        let constrainingToSuperView = (targetView === superview)

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .left,
                                            relatedBy: relation,
                                            toItem: useSafeAreas ? targetView.safeAreaLayoutGuide : targetView,
                                            attribute: constrainingToSuperView ? .left : .right,
                                            multiplier: 1.0,
                                            constant: spacing)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoSetRightSpace(_ spacing: CGFloat = 0,
                                              toView: UIView? = nil,
                                              relation: NSLayoutConstraint.Relation = .equal,
                                              useSafeAreas: Bool = false) -> NSLayoutConstraint {
        guard let superview = self.superview else { fatalError("View does not have a superview") }

        let targetView = toView ?? superview
        let constrainingToSuperView = (targetView === superview)

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .right,
                                            relatedBy: relation,
                                            toItem: useSafeAreas ? targetView.safeAreaLayoutGuide : targetView,
                                            attribute: constrainingToSuperView ? .right : .left,
                                            multiplier: 1.0,
                                            constant: -spacing)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoSetBottomSpace(_ spacing: CGFloat = 0,
                                               toView: UIView? = nil,
                                               relation: NSLayoutConstraint.Relation = .equal,
                                               useSafeAreas: Bool = false) -> NSLayoutConstraint {
        guard let superview = self.superview else { fatalError("View does not have a superview") }

        let targetView = toView ?? superview
        let constrainingToSuperView = (targetView === superview)

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: relation,
                                            toItem: useSafeAreas ? targetView.safeAreaLayoutGuide : targetView,
                                            attribute: constrainingToSuperView ? .bottom : .top,
                                            multiplier: 1.0,
                                            constant: -spacing)
        applyConstraint(constraint)
        return constraint
    }

    // MARK: Fitting
    @discardableResult func autoFitHorizontally(withMargins margins: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            autoSetLeftSpace(margins),
            autoSetRightSpace(margins)
        ]
    }

    @discardableResult func autoFitVertically(withMargins margins: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            autoSetTopSpace(margins),
            autoSetBottomSpace(margins)
        ]
    }

    @discardableResult func autoFit(withMargins margins: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            autoSetTopSpace(margins),
            autoSetLeftSpace(margins),
            autoSetRightSpace(margins),
            autoSetBottomSpace(margins)
        ]
    }

    // MARK: Centering
    @discardableResult func autoCenterVertically(withOffset offset: CGFloat = 0,
                                                 withView: UIView? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: withView ?? superview,
                                            attribute: .centerY,
                                            multiplier: 1.0,
                                            constant: offset)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoCenterHorizontally(withOffset offset: CGFloat = 0,
                                                   withView: UIView? = nil) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: withView ?? superview,
                                            attribute: .centerX,
                                            multiplier: 1.0,
                                            constant: offset)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoCenter(withView view: UIView? = nil) -> [NSLayoutConstraint] {
        return [
            autoCenterVertically(withView: view),
            autoCenterHorizontally(withView: view)
        ]
    }

    // MARK: - Alignment
    @discardableResult func autoAlignTop(with view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .top,
                                            multiplier: 1.0,
                                            constant: offset)
        applyConstraint(constraint)
        return constraint
    }

    @discardableResult func autoAlignBottom(with view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: offset)
        applyConstraint(constraint)
        return constraint
    }
}
