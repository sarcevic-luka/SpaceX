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

class LaunchListCell: UICollectionViewCell {
  struct ViewModel {
    let missionIconURL: URL
    let missionName: String
    let missionTime: String
    let rocketDetails: String
    let isInPast: Bool
    let daysCount: String
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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LaunchListCell {
  func update(_ viewModel: ViewModel) {
    missionImageView.kf.setImage(
      with: viewModel.missionIconURL,
      placeholder: ImageAssets.Icons.shuttle.image,
      options: [
        .transition(.fade(1)),
        .cacheOriginalImage
      ])
    missionNameTitleLabel.text = viewModel.missionName
    daysCountTitleLabel.text = viewModel.isInPast ? "Days since now" : "Days from now"
    missionNameLabel.text = viewModel.missionName
    timeLabel.text = viewModel.missionTime
    rocketDetailsLabel.text = viewModel.rocketDetails
    daysCountLabel.text = viewModel.daysCount
    launchSuccessIndicatorImageView.image = viewModel.launchWasSuccessful ? ImageAssets.Icons.success.image : ImageAssets.Icons.failure.image
    [verticalTitlesStackView, verticalValuesStackView].forEach { $0.fadeIn() }
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
  }
  
  func setupView() {
    contentView.backgroundColor = ColorAssets.General.appWhite.color
  }
  
  func setupIndicatorView() {
    addSubview(indicatorView)
    indicatorView.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    indicatorView.hidesWhenStopped = true
    indicatorView.color = ColorAssets.General.appBlack.color.withAlphaComponent(0.7)
    indicatorView.startAnimating()
  }
  
  func setupMissionImageView() {
    addSubview(missionImageView)
    missionImageView.snp.makeConstraints {
      $0.size.equalTo(40)
      $0.top.leading.equalToSuperview().inset(20)
    }
  }
  
  func setupVerticalTitlesStackView() {
    addSubview(verticalTitlesStackView)
    verticalTitlesStackView.snp.makeConstraints {
      $0.leading.equalTo(missionImageView.snp.trailing).offset(12)
      $0.top.bottom.equalToSuperview().inset(12)
      $0.width.equalTo(80)
    }
    verticalTitlesStackView.axis = .vertical
    verticalTitlesStackView.distribution = .fillEqually
    verticalTitlesStackView.alignment = .leading
    verticalTitlesStackView.fadeOut(0.0)
  }
  
  func setupTitlesLabels() {
    let stackViewTitles = [missionNameTitleLabel, timeTitleLabel, rocketDetailsTitleLabel, daysCountTitleLabel]
    missionNameTitleLabel.text = "Base expirience:"
    timeTitleLabel.text = "Types:"
    rocketDetailsTitleLabel.text = "Weight:"
    daysCountTitleLabel.text = ""
    
    stackViewTitles.forEach { label in
      label.font = .appFont(size: 14, weight: .regular)
      label.textColor = ColorAssets.General.appBlack.color
      verticalTitlesStackView.addArrangedSubview(label)
    }
  }
  
  func setupVerticalValuesStackView() {
    addSubview(verticalValuesStackView)
    verticalValuesStackView.snp.makeConstraints {
      $0.leading.equalTo(verticalTitlesStackView.snp.trailing).offset(12)
      $0.top.bottom.equalToSuperview().inset(12)
      $0.width.equalTo(80)
    }
    verticalValuesStackView.axis = .vertical
    verticalValuesStackView.distribution = .fillEqually
    verticalValuesStackView.alignment = .leading
    verticalValuesStackView.fadeOut(0.0)
  }
  
  func setupValuesLabels() {
    let stackViewTitles = [missionNameLabel, timeLabel, rocketDetailsLabel, daysCountLabel]
    
    stackViewTitles.forEach { label in
      label.font = .systemFont(ofSize: 16, weight: .medium)
      label.textColor = ColorAssets.General.appBlack.color.withAlphaComponent(0.7)
      label.text = " "
      verticalValuesStackView.addArrangedSubview(label)
    }
  }
  
  func setupLaunchSuccessIndicatorImageView() {
    addSubview(launchSuccessIndicatorImageView)
    launchSuccessIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(40)
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(verticalValuesStackView.snp.trailing).inset(12)
      $0.trailing.equalToSuperview().inset(12)
    }
  }
}
