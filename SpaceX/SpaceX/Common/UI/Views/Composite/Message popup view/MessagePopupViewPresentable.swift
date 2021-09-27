//
//  MessagePopupViewPresentable.swift
//  SpaceX
//
//  Created by Luka Šarčević on 28.09.2021..
//

import UIKit

protocol MessagePopupViewPresentable: AnyObject {
  var messagePopup: MessagePopupView? { get set }
  var containerView: UIView { get }
  func presentMessagePopup(_ popup: MessagePopupView, completion: Action?)
  func dismissMessagePopup(completion: Action?)
}

extension MessagePopupViewPresentable where Self: UIViewController {
  var containerView: UIView { view }
  
  func presentMessagePopup(_ popup: MessagePopupView, completion: Action?) {
    func presentPopup(completion: Action?) {
      self.messagePopup = popup
      
      self.messagePopup?.actionHandler =  { [weak self] in
        self?.dismissMessagePopup(completion: completion)
      }
      
      layoutMessagePopup(popup, in: containerView)
      applyInitialTransformToPopup(popup)
      
      if let autoDismissalInterval = popup.autoDismissInterval {
        DispatchQueue.main.asyncAfter(deadline: .now() + autoDismissalInterval) {
          if self.messagePopup == popup {
            self.dismissMessagePopup(completion: completion)
          }
        }
      }
      
      return animateMessagePopupIn(popup, completion: completion)
    }
    
    if let existingPopup = messagePopup, existingPopup.isDescendant(of: containerView) {
      return dismissMessagePopup(completion: { presentPopup(completion: completion) })
    } else {
      return presentPopup(completion: completion)
    }
  }
  
  func dismissMessagePopup(completion: Action?) {
    guard let popup = messagePopup else {
      completion?()
      return
    }
    return animateMessagePopupOut(popup, completion: completion)
  }
}

private extension MessagePopupViewPresentable where Self: UIViewController {
  func layoutMessagePopup(_ popup: MessagePopupView, in view: UIView) {
    view.addSubview(popup)
    popup.snp.makeConstraints {
      $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
    }
  }
  
  func applyInitialTransformToPopup(_ popup: MessagePopupView) {
    popup.transform = CGAffineTransform(translationX: -self.containerView.bounds.width * 0.5, y: 0)
    popup.alpha = 0.0
  }
  
  func applyVisibleTransformToPopup(_ popup: MessagePopupView) {
    popup.transform = .identity
    popup.alpha = 1.0
  }
  
  func applyEndTransformToPopup(_ popup: MessagePopupView) {
    popup.transform = CGAffineTransform(translationX: self.containerView.bounds.width * 0.5, y: 0)
    popup.alpha = 0.0
  }
  
  func animateMessagePopupIn(_ popup: MessagePopupView, completion: Action?) {
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.0, options: [], animations: {
      self.applyVisibleTransformToPopup(popup)
    }, completion: { _ in
      completion?()
    })
  }
  
  func animateMessagePopupOut(_ popup: MessagePopupView, completion: Action?) {
    UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.0, options: [], animations: {
      self.applyEndTransformToPopup(popup)
    }, completion: { _ in
      self.messagePopup?.removeFromSuperview()
      self.messagePopup = nil
      completion?()
    })
  }
}
