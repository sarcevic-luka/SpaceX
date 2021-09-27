//
//  LaunchListCell.swift
//  SpaceX
//
//  Created by Luka Šarčević on 26.09.2021..
//

import UIKit
import Assets
import Kingfisher
import SnapKit

class LaunchListCell: UITableViewCell {
  struct ViewModel {
    let missionIconURL: URL?
    let missionName: String
    let missionTime: String
    let rocketDetails: String
    let daysCount: Int
    let launchWasSuccessful: Bool
  }
  private lazy var indicatorView = UIActivityIndicatorView()
  private lazy var missionImageView = UIImageView()
  private lazy var verticalTitlesStackView = UIStackView()
  private lazy var missionNameTitleLabel = UILabel()
  private lazy var timeTitleLabel = UILabel()
  private lazy var rocketDetailsTitleLabel = UILabel()
  private lazy var daysCountTitleLabel = UILabel()
  private lazy var verticalValuesStackView = UIStackView()
  private lazy var missionNameLabel = UILabel()
  private lazy var timeLabel = UILabel()
  private lazy var rocketDetailsLabel = UILabel()
  private lazy var daysCountLabel = UILabel()
  private lazy var launchSuccessIndicatorImageView = UIImageView()
  private lazy var separatorView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LaunchListCell {
  func update(_ viewModel: ViewModel?) {
    guard let model = viewModel else {
      indicatorView.startAnimating()
      missionImageView.image = nil
      [verticalTitlesStackView, verticalValuesStackView].forEach { $0.fadeOut(0.0) }
      return
    }
    missionImageView.kf.setImage(
      with: model.missionIconURL,
      placeholder: ImageAssets.Icons.shuttle.image,
      options: [
        .transition(.fade(1)),
        .cacheOriginalImage
      ])
    missionNameLabel.text = model.missionName
    daysCountTitleLabel.text = model.daysCount < 0 ? "Days since now:" : "Days from now:"
    missionNameLabel.text = model.missionName
    timeLabel.text = model.missionTime
    rocketDetailsLabel.text = model.rocketDetails
    daysCountLabel.text = "\(model.daysCount)"
    launchSuccessIndicatorImageView.image = model.launchWasSuccessful ? ImageAssets.Icons.success.image : ImageAssets.Icons.failure.image
    [verticalTitlesStackView, verticalValuesStackView].forEach { $0.fadeIn(0.2) }
    indicatorView.stopAnimating()
  }
}

// MARK: - Private Methods
private extension LaunchListCell {
  func setupViews() {
    setupView()
    setupIndicatorView()
    setupMissionImageView()
    setupVerticalTitlesStackView()
    setupTitlesLabels()
    setupVerticalValuesStackView()
    setupValuesLabels()
    setupLaunchSuccessIndicatorImageView()
    setupSeparatorView()
  }
  
  func setupView() {
    contentView.backgroundColor = ColorAssets.General.white.color
    backgroundColor = ColorAssets.General.white.color
  }
  
  func setupIndicatorView() {
    addSubview(indicatorView)
    indicatorView.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    indicatorView.hidesWhenStopped = true
    indicatorView.color = ColorAssets.General.gray.color
  }
  
  func setupMissionImageView() {
    addSubview(missionImageView)
    missionImageView.snp.makeConstraints {
      $0.size.equalTo(40)
      $0.leading.equalToSuperview().inset(8)
      $0.top.equalToSuperview().inset(16)
    }
  }
  
  func setupVerticalTitlesStackView() {
    addSubview(verticalTitlesStackView)
    verticalTitlesStackView.snp.makeConstraints {
      $0.leading.equalTo(missionImageView.snp.trailing).offset(12)
      $0.top.bottom.equalToSuperview().inset(12)
      $0.width.equalTo(95)
    }
    verticalTitlesStackView.axis = .vertical
    verticalTitlesStackView.distribution = .fillEqually
    verticalTitlesStackView.alignment = .leading
    verticalTitlesStackView.fadeOut(0.0)
  }
  
  func setupTitlesLabels() {
    let stackViewTitles = [missionNameTitleLabel, timeTitleLabel, rocketDetailsTitleLabel, daysCountTitleLabel]
    missionNameTitleLabel.text = "Mission:"
    timeTitleLabel.text = "Types:"
    rocketDetailsTitleLabel.text = "Weight:"
    daysCountTitleLabel.text = ""
    
    stackViewTitles.forEach { label in
      label.font = .appFont(size: 14, weight: .regular)
      label.textColor = ColorAssets.General.gray.color
      verticalTitlesStackView.addArrangedSubview(label)
    }
  }
  
  func setupVerticalValuesStackView() {
    addSubview(verticalValuesStackView)
    verticalValuesStackView.snp.makeConstraints {
      $0.leading.equalTo(verticalTitlesStackView.snp.trailing).offset(12)
      $0.top.bottom.equalToSuperview().inset(12)
    }
    verticalValuesStackView.axis = .vertical
    verticalValuesStackView.distribution = .fillEqually
    verticalValuesStackView.alignment = .leading
    verticalValuesStackView.fadeOut(0.0)
  }
  
  func setupValuesLabels() {
    let stackViewTitles = [missionNameLabel, timeLabel, rocketDetailsLabel, daysCountLabel]
    
    stackViewTitles.forEach { label in
      label.font = .appFont(size: 14, weight: .regular)
      label.textColor = ColorAssets.General.appBlack.color
      label.text = " "
      verticalValuesStackView.addArrangedSubview(label)
    }
  }
  
  func setupLaunchSuccessIndicatorImageView() {
    addSubview(launchSuccessIndicatorImageView)
    launchSuccessIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(30)
      $0.leading.equalTo(verticalValuesStackView.snp.trailing).inset(-12)
      $0.top.trailing.equalToSuperview().inset(12)
    }
  }
  
  func setupSeparatorView() {
    addSubview(separatorView)
    separatorView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(2)
    }
    separatorView.backgroundColor = ColorAssets.General.gray.color
  }
}
