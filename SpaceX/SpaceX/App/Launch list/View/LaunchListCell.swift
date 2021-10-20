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
  private let missionImageView = UIImageView()
  private let verticalTitlesStackView = UIStackView()
  private let missionNameTitleLabel = UILabel()
  private let timeTitleLabel = UILabel()
  private let rocketDetailsTitleLabel = UILabel()
  private let daysCountTitleLabel = UILabel()
  private let verticalValuesStackView = UIStackView()
  private let missionNameLabel = UILabel()
  private let timeLabel = UILabel()
  private let rocketDetailsLabel = UILabel()
  private let daysCountLabel = UILabel()
  private let launchSuccessIndicatorImageView = UIImageView()
  private let separatorView = UIView()
  
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
  func update(_ viewModel: ViewModel) {
    missionImageView.kf.setImage(
      with: viewModel.missionIconURL,
      placeholder: ImageAssets.Icons.shuttle.image,
      options: [
        .transition(.fade(1)),
        .cacheOriginalImage
      ])
    missionNameLabel.text = viewModel.missionName
    daysCountTitleLabel.text = viewModel.daysCount < 0 ? "Days since now:" : "Days from now:"
    missionNameLabel.text = viewModel.missionName
    timeLabel.text = viewModel.missionTime
    rocketDetailsLabel.text = viewModel.rocketDetails
    daysCountLabel.text = "\(viewModel.daysCount)"
    launchSuccessIndicatorImageView.image = viewModel.launchWasSuccessful ? ImageAssets.Icons.success.image : ImageAssets.Icons.failure.image
    [verticalTitlesStackView, verticalValuesStackView].forEach { $0.fadeIn(0.2) }
  }
}

// MARK: - Private Methods
private extension LaunchListCell {
  func setupViews() {
    setupView()
    setupMissionImageView()
    setupVerticalTitlesStackView()
    setupTitlesLabels()
    setupVerticalValuesStackView()
    setupValuesLabels()
    setupLaunchSuccessIndicatorImageView()
//    setupSeparatorView()
  }
  
  func setupView() {
    contentView.backgroundColor = ColorAssets.General.white.color
    backgroundColor = ColorAssets.General.white.color
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
