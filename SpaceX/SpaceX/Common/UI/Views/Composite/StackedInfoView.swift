//
//  StackedInfoView.swift
//  SpaceX
//
//  Created by Luka Šarčević on 27.09.2021..
//

import UIKit
import Assets

class StackedInfoView: UIView {
  private(set) lazy var stackView = UIStackView()
  private(set) lazy var titleLabel = UILabel()
  private(set) lazy var subtitleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension StackedInfoView {
  var spacing: CGFloat {
    get { return stackView.spacing }
    set { stackView.spacing = newValue }
  }

  var title: String? {
    get { return titleLabel.text }
    set {
      titleLabel.text = newValue
      titleLabel.isHidden = newValue == nil
    }
  }

  var titleFont: UIFont? {
    get { return titleLabel.font }
    set { titleLabel.font = newValue }
  }

  var titleColor: UIColor? {
    get { return titleLabel.textColor }
    set { titleLabel.textColor = newValue }
  }

  var titleAlignmnent: NSTextAlignment? {
    get { return titleLabel.textAlignment }
    set { titleLabel.textAlignment = newValue ?? .left }
  }

  var titleNumberOfLines: Int {
    get { return titleLabel.numberOfLines }
    set { titleLabel.numberOfLines = newValue }
  }

  var subtitle: String? {
    get { return subtitleLabel.text }
    set {
      subtitleLabel.text = newValue
      subtitleLabel.isHidden = newValue == nil
    }
  }

  var attributedSubtitle: NSAttributedString? {
    get { return subtitleLabel.attributedText }
    set { subtitleLabel.attributedText = newValue }
  }

  var subtitleFont: UIFont? {
    get { return subtitleLabel.font }
    set { subtitleLabel.font = newValue }
  }

  var subtitleColor: UIColor? {
    get { return subtitleLabel.textColor }
    set { subtitleLabel.textColor = newValue }
  }

  var subtitleAlignmnent: NSTextAlignment? {
    get { return subtitleLabel.textAlignment }
    set { subtitleLabel.textAlignment = newValue ?? .left }
  }

  var subtitleNumberOfLines: Int {
    get { return subtitleLabel.numberOfLines }
    set { subtitleLabel.numberOfLines = newValue }
  }
}

// MARK: - Private Methods
private extension StackedInfoView {
  func setupViews() {
    setupStackView()
    setupTitleLabel()
    setupSubtitleLabel()
  }

  func setupStackView() {
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 4
  }

  func setupTitleLabel() {
    stackView.addArrangedSubview(titleLabel)
    titleLabel.font = .appFont(size: 18, weight: .bold)
    titleLabel.textColor = ColorAssets.General.appBlack.color
    titleLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
    titleLabel.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
  }

  func setupSubtitleLabel() {
    stackView.addArrangedSubview(subtitleLabel)
    subtitleLabel.font = .appFont(size: 16, weight: .medium)
    subtitleLabel.textColor = ColorAssets.General.gray.color
    subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
  }
}
