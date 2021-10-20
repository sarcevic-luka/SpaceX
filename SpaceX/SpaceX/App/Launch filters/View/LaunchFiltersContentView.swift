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
  var sortByAscending: ParametrisedAction<String?>?
  var applyFilterTapHandler: Action?
  var cancelTapHandler: Action?
  private(set) lazy var blurView = UIVisualEffectView(effect: blurEffect)
  private let blurEffect = UIBlurEffect(style: .light)
  private let containerView = UIView()
  private let verticalStackView = UIStackView()
  private let titleLabel = UILabel()
  // by year - switch
  private let yearsHorizontalStackView = UIStackView()
  private let yearsTitleLabel = UILabel()
  private let yearsSwitch = UISwitch()
  // year label - slider
  private let yearsSliderHorizontalStackView = UIStackView()
  private let yearsSlider = UISlider()
  private let selectedYearLabel = UILabel()
  // by success - switch
  private let successfulLaunchHorizontalStackView = UIStackView()
  private let successfulLaunchTitleLabel = UILabel()
  private let successfulLaunchSwitch = UISwitch()
  // success/failed - switch
  private let successfulLaunchIndicatorHorizontalStackView = UIStackView()
  private let successfulLaunchIndicatorLabel = UILabel()
  private let launchSuccessIndicatorSwitch = UISwitch()
  // sorting - switch
  private let sortHorizontalStackView = UIStackView()
  private let sortTitleLabel = UILabel()
  private let sortSwitch = UISwitch()
  // filter and cancel buttons
  private let cancelButton = UIButton(type: .system)
  private let filterButton = UIButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LaunchFiltersContentView {
  func setOnSelectedFilter(with year: Int?) {
    guard let selectedYear = year else { return }
    yearsSwitch.isOn = true
    yearsSlider.value = Float(selectedYear)
    selectedYearLabel.text = " year: \(selectedYear)"
    yearsSliderHorizontalStackView.fadeIn(0)
  }
  
  func setOnFilter(succesfulLaunch: Bool?) {
    guard let successfulLaunchFilter = succesfulLaunch else { return }
    successfulLaunchSwitch.isOn = true
    launchSuccessIndicatorSwitch.isOn = successfulLaunchFilter
    successfulLaunchIndicatorHorizontalStackView.fadeIn()
    successfulLaunchIndicatorLabel.fadeIn()
    filterBySuccessfulLaunch?(launchSuccessIndicatorSwitch.isOn)
  }
  
  func setCurrent(sortingRule: String?) {
    if sortingRule == "desc" {
      sortSwitch.isOn = false
      sortTitleLabel.text = "- sort: Descending"
    } else {
      sortSwitch.isOn = true
      sortTitleLabel.text = "- sort: Ascending"
    }
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
      filterBySuccessfulLaunch?(launchSuccessIndicatorSwitch.isOn)
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
    sortByAscending?(sender.isOn ? "asc" : "desc")
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
    successfulLaunchIndicatorHorizontalStackView.addArrangedSubview(launchSuccessIndicatorSwitch)
    launchSuccessIndicatorSwitch.isOn = true
    launchSuccessIndicatorSwitch.onTintColor = ColorAssets.General.appBlack.color
    launchSuccessIndicatorSwitch.addTarget(self, action: #selector(launchValueChanged(_:)), for: .touchUpInside)
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
    verticalStackView.setCustomSpacing(16, after: sortHorizontalStackView)
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
    cancelButton.setTitleColor(ColorAssets.General.red.color, for: .normal)
    cancelButton.titleLabel?.font = .appFont(size: 16, weight: .bold)
  }
  
  func setupFilterButton() {
    verticalStackView.addArrangedSubview(filterButton)
    filterButton.setTitle("Filter", for: .normal)
    filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
    filterButton.setTitleColor(ColorAssets.General.appBlack.color, for: .normal)
    filterButton.titleLabel?.font = .appFont(size: 16, weight: .bold)
  }
}
