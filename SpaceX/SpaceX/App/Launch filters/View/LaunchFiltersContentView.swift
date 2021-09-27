//
//  LaunchFiltersContentView.swift
//  SpaceX
//
//  Created Luka Šarčević on 27.09.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Assets
import SnapKit

class LaunchFiltersContentView: UIView {
  var yearsSliderHandler: ParametrisedAction<Int?>?
  var filterBySuccessfulLaunch: ParametrisedAction<Bool?>?
  var sortByAsscending: ParametrisedAction<String?>?
  var applyFilterTapHandler: Action?
  var cancelTapHandler: Action?
  private lazy var blurView = UIVisualEffectView(effect: blurEffect)
  private lazy var blurEffect = UIBlurEffect(style: .light)
  private lazy var containerView = UIView()
  private lazy var verticalStackView = UIStackView()
  private lazy var titleLabel = UILabel()
  // by year - switch
  private lazy var yearsHorizontalStackView = UIStackView()
  private lazy var yearsTitleLabel = UILabel()
  private lazy var yearsSwitch = UISwitch()
  // year label - slider
  private lazy var yearsSliderHorizontalStackView = UIStackView()
  private lazy var yearsSlider = UISlider()
  private lazy var selectedYearLabel = UILabel()
  // by success - switch
  private lazy var successfulLaunchHorizontalStackView = UIStackView()
  private lazy var successfulLaunchTitleLabel = UILabel()
  private lazy var successfulLaunchSwitch = UISwitch()
  // success/failed - switch
  private lazy var successfulLaunchIndicatorHorizontalStackView = UIStackView()
  private lazy var successfulLaunchIndicatorLabel = UILabel()
  private lazy var successfulFaliureSwitch = UISwitch()
  // sorting - switch
  private lazy var sortHorizontalStackView = UIStackView()
  private lazy var sortTitleLabel = UILabel()
  private lazy var sortSwitch = UISwitch()
  // filter and cancel buttons
  private lazy var cancelButton = UIButton(type: .system)
  private lazy var filterButton = UIButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods
private extension LaunchFiltersContentView {
  @objc func yearsSwitchValueChanged(_ sender: UISwitch) {
    if sender.isOn {
      yearsSliderHorizontalStackView.fadeIn()
    } else {
      yearsSliderHandler?(nil)
      yearsSliderHorizontalStackView.fadeOut()
    }
  }
  
  @objc func yearsValueChanged(_ sender: UISlider) {
    yearsSliderHandler?(Int(sender.value))
    selectedYearLabel.text = " year: \(Int(sender.value))"
  }

  @objc func launchSwitch(_ sender: UISwitch) {
    if sender.isOn {
      successfulLaunchIndicatorHorizontalStackView.fadeIn()
      successfulLaunchIndicatorLabel.fadeIn()
      filterBySuccessfulLaunch?(successfulFaliureSwitch.isOn)
    } else {
      filterBySuccessfulLaunch?(nil)
      successfulLaunchIndicatorLabel.fadeOut()
      successfulLaunchIndicatorHorizontalStackView.fadeOut()
    }
  }

  @objc func launchValueChanged(_ sender: UISwitch) {
    filterBySuccessfulLaunch?(sender.isOn)
    successfulLaunchIndicatorLabel.text = sender.isOn ? "showing successful only -" : "showing only unsuccessful -"
  }

  @objc func sortValueChanged(_ sender: UISwitch) {
    sortByAsscending?(sender.isOn ? "asc" : "desc")
    sortTitleLabel.text = sender.isOn ? "- sort: Ascending" : "- sort: Descending"
  }

  @objc func cancelButtonTapped(_ sender: UIButton) {
    cancelTapHandler?()
  }

  @objc func filterButtonTapped(_ sender: UIButton) {
    applyFilterTapHandler?()
  }
}


private extension LaunchFiltersContentView {
  func setupViews() {
    setupBlurView()
    setupContainerView()
    setupVerticalStackView()
    setupTitleLabel()
    setupHorizontalStackViews()
    setupYearsTitleLabel()
    setupYearsSwitch()
    setupYearsSlider()
    setupSelectedYearLabel()
    setupSuccessfulLaunchTitleLabel()
    setupSuccessfulLaunchSwitch()
    setupSuccessfulLaunchIndicatorLabel()
    setupSuccessfulFaliureSwitch()
    setupSortTitleLabel()
    setupSortSwitch()
    setupCancelButton()
    setupFilterButton()
  }
  
  func setupBlurView() {
    addSubview(blurView)
    blurView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    blurView.backgroundColor = ColorAssets.General.gray.color.withAlphaComponent(0.2)
  }

  func setupContainerView() {
    blurView.contentView.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.7)
    }
    containerView.backgroundColor = ColorAssets.General.white.color
    containerView.layer.cornerRadius = 16
    containerView.clipsToBounds = true
  }

  func setupVerticalStackView() {
    containerView.addSubview(verticalStackView)
    verticalStackView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(12)
      $0.bottom.equalToSuperview().inset(12).priority(.high)
    }
    verticalStackView.spacing = 12
    verticalStackView.axis = .vertical
    verticalStackView.alignment = .fill
    verticalStackView.distribution = .fill
  }
  
  func setupTitleLabel() {
    verticalStackView.addArrangedSubview(titleLabel)
    titleLabel.font = .appFont(size: 18, weight: .bold)
    titleLabel.textColor = ColorAssets.General.appBlack.color
    titleLabel.text = "Select filters:"
    titleLabel.textAlignment = .center
  }
  
  func setupHorizontalStackViews() {
    [yearsHorizontalStackView, yearsSliderHorizontalStackView, successfulLaunchHorizontalStackView, successfulLaunchIndicatorHorizontalStackView, sortHorizontalStackView].forEach { stackView in
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.distribution = .fill
      stackView.spacing = 6
      verticalStackView.addArrangedSubview(stackView)
    }
    [yearsSliderHorizontalStackView, successfulLaunchIndicatorHorizontalStackView].forEach { valueStackView in
      valueStackView.fadeOut(0)
    }
  }
  
  func setupYearsTitleLabel() {
    yearsHorizontalStackView.addArrangedSubview(yearsTitleLabel)
    yearsTitleLabel.font = .appFont(size: 16, weight: .medium)
    yearsTitleLabel.textColor = ColorAssets.General.appBlack.color
    yearsTitleLabel.text = "- by year"
  }
  
  func setupYearsSwitch() {
    yearsHorizontalStackView.addArrangedSubview(yearsSwitch)
    yearsSwitch.onTintColor = ColorAssets.General.appBlack.color
    yearsSwitch.addTarget(self, action: #selector(yearsSwitchValueChanged(_:)), for: .touchUpInside)
  }
  
  func setupYearsSlider() {
    yearsSliderHorizontalStackView.addArrangedSubview(yearsSlider)
    yearsSlider.minimumValue = 2006
    yearsSlider.maximumValue = 2028
    yearsSlider.tintColor = ColorAssets.General.appBlack.color
    yearsSlider.addTarget(self, action: #selector(yearsValueChanged(_:)), for: .touchUpInside)
  }
  
  func setupSelectedYearLabel() {
    yearsSliderHorizontalStackView.addArrangedSubview(selectedYearLabel)
    selectedYearLabel.font = .appFont(size: 14, weight: .medium)
    selectedYearLabel.textColor = ColorAssets.General.gray.color
    selectedYearLabel.text = "Slide to pick"
  }
  
  func setupSuccessfulLaunchTitleLabel() {
    successfulLaunchHorizontalStackView.addArrangedSubview(successfulLaunchTitleLabel)
    successfulLaunchTitleLabel.font = .appFont(size: 16, weight: .medium)
    successfulLaunchTitleLabel.textColor = ColorAssets.General.appBlack.color
    successfulLaunchTitleLabel.text = "- by successful launch"
  }
  
  func setupSuccessfulLaunchSwitch() {
    successfulLaunchHorizontalStackView.addArrangedSubview(successfulLaunchSwitch)
    successfulLaunchSwitch.onTintColor = ColorAssets.General.appBlack.color
    successfulLaunchSwitch.addTarget(self, action: #selector(launchSwitch(_:)), for: .touchUpInside)
  }
  
  func setupSuccessfulLaunchIndicatorLabel() {
    successfulLaunchIndicatorHorizontalStackView.addArrangedSubview(successfulLaunchIndicatorLabel)
    successfulLaunchIndicatorLabel.font = .appFont(size: 14, weight: .medium)
    successfulLaunchIndicatorLabel.textColor = ColorAssets.General.gray.color
    successfulLaunchIndicatorLabel.textAlignment = .right
    successfulLaunchIndicatorLabel.text = "showing successful only -"
  }
  
  func setupSuccessfulFaliureSwitch() {
    successfulLaunchIndicatorHorizontalStackView.addArrangedSubview(successfulFaliureSwitch)
    successfulFaliureSwitch.isOn = true
    successfulFaliureSwitch.onTintColor = ColorAssets.General.appBlack.color
    successfulFaliureSwitch.addTarget(self, action: #selector(launchValueChanged(_:)), for: .touchUpInside)
  }
  
  func setupSortTitleLabel() {
    sortHorizontalStackView.addArrangedSubview(sortTitleLabel)
    sortTitleLabel.font = .appFont(size: 16, weight: .medium)
    sortTitleLabel.textColor = ColorAssets.General.appBlack.color
    sortTitleLabel.text = "- sort: Ascending"
  }
  
  func setupSortSwitch() {
    sortHorizontalStackView.addArrangedSubview(sortSwitch)
    sortSwitch.isOn = true
    sortSwitch.onTintColor = ColorAssets.General.appBlack.color
    sortSwitch.addTarget(self, action: #selector(sortValueChanged(_:)), for: .touchUpInside)
  }
  
  func setupCancelButton() {
    verticalStackView.addArrangedSubview(cancelButton)
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
    cancelButton.setTitleColor(ColorAssets.General.red.color, for: .normal)
  }
  
  func setupFilterButton() {
    verticalStackView.addArrangedSubview(filterButton)
    filterButton.setTitle("Filter", for: .normal)
    filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
    filterButton.setTitleColor(ColorAssets.General.appBlack.color, for: .normal)
  }
}
