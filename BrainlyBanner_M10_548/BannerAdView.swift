//
//  Created on 06/09/2022.
//  Copyright © 2022 Brainly sp. z o.o. All rights reserved.
//

import FreestarAds
import Foundation
import UIKit

final class BannerAdView: UIView {
    private let headerLabel = UILabel().makeAutoLayoutable()
    private let adContainerView = UIView().makeAutoLayoutable()

    private var adHeightConstraint: NSLayoutConstraint!
    private var adWidthConstraint: NSLayoutConstraint!
    private var freestarBanner: FreestarBannerAd? {
        didSet {
            oldValue?.removeFromSuperview()

            guard let freestarBanner = freestarBanner else { return }

            adContainerView.addSubview(freestarBanner)
            NSLayoutConstraint.activate([
                adContainerView.centerXAnchor.constraint(equalTo: freestarBanner.centerXAnchor),
                adContainerView.centerYAnchor.constraint(equalTo: freestarBanner.centerYAnchor)
            ])
        }
    }

    var bannerAdType: BannerAdType = .mediumRectangle {
        didSet {
            let bannerSize = bannerAdType.size
            adHeightConstraint.constant = bannerSize.height
            adWidthConstraint.constant = bannerSize.width
        }
    }

    // MARK: - Init methods

    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Public

    public func loadAd() {
        // M10-548: Layout conflict affecting TAM CTA 
//        let banner = FreestarBannerAd(delegate: self, andSize: bannerAdType.freestarBannerSize).makeAutoLayoutable()
        let banner = FreestarBannerAd(delegate: self, andSize: bannerAdType.freestarBannerSize)
        banner.loadPlacement(nil)

        self.freestarBanner = banner
    }

    public func stopAd() {
        freestarBanner = nil
    }

    // MARK: - Private

    /// Setup View's properties.
    private func setupProperties() {
        headerLabel.textAlignment = .center
        headerLabel.text = "Brainly header label"
//        headerLabel.text = Localizable.Ads.advertisement
//        headerLabel.font = UIFont.Headline.xsmall.bold
//        headerLabel.textColor = .brainlyGray50
    }

    /// Setup subviews.
    private func setupSubviews() {
        addSubview(headerLabel)
        addSubview(adContainerView)
    }

    /// Setup constraints.
    private func setupConstraints() {
        let bannerSize = bannerAdType.size
        adHeightConstraint = adContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: bannerSize.height)
        adWidthConstraint = adContainerView.widthAnchor.constraint(greaterThanOrEqualToConstant: bannerSize.width)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topMargin),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            adContainerView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Constant.headerToBannerSpacing),
            adContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            adContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            adContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            adHeightConstraint,
            adWidthConstraint
        ])
    }

    private func setupAccessibility() {
        adContainerView.accessibilityIdentifier = "ad_container"
    }

    private func commonInit() {
        setupSubviews()
        setupProperties()
        setupConstraints()
        setupAccessibility()
    }
}

private extension BannerAdView {
    enum Constant {
        static let topMargin: CGFloat = 8
        static let headerToBannerSpacing: CGFloat = 4
    }
}

extension BannerAdView {
    enum BannerAdType {
        case mediumRectangle

        fileprivate var size: CGSize {
            switch self {
            case .mediumRectangle: return CGSize(width: 300, height: 250)
            }
        }

        fileprivate var freestarBannerSize: FreestarBannerAdSize {
            switch self {
            case .mediumRectangle: return .banner300x250
            }
        }
    }
}

extension BannerAdView: FreestarBannerAdDelegate {
    func freestarBannerLoaded(_ ad: FreestarBannerAd) {
        // TODO: analytics
    }

    func freestarBannerFailed(_ ad: FreestarBannerAd, because reason: FreestarNoAdReason) {
        // TODO: analytics
    }

    func freestarBannerClicked(_ ad: FreestarBannerAd) {
        print("CLICK")
    }
}

extension UIView {
    func makeAutoLayoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
