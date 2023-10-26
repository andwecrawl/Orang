//
//  SplashViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/25.
//

import UIKit

class SplashViewController: BaseViewController, MoveToFirstScene {
    
    let imageView = UIView(frame: .zero)
    let todayLabel = {
        let label = UILabel()
        label.text = "     오늘도"
        label.textColor = .white
        label.font = Design.Font.changwon.getFonts(size: 60)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 8
        label.layer.shadowOpacity = 0.1
        return label
    }()
    let loveLabel = {
        let label = UILabel()
        label.text = "사랑해!"
        label.textColor = .white
        label.font = Design.Font.changwon.getFonts(size: 60)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 8
        label.layer.shadowOpacity = 0.1
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("hello")
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        configureBackground()
        // Start the animation manually:
        
        let blur = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blur)
        visualEffectView.frame = self.view.frame
        view.addSubview(visualEffectView)
        view.addSubview(imageView)
        view.addSubview(todayLabel)
        view.addSubview(loveLabel)
    }
    
    func configureBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.systemRed.cgColor]
        view.layer.addSublayer(gradientLayer)
        
    }
    
    override func setConstraints() {
        
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(104)
//            make.trailing.equalTo(todayLabel)
            make.bottom.equalTo(todayLabel.snp.top).inset(10)
            make.size.equalTo(70)
        }
        
        
        todayLabel.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
        
        loveLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(todayLabel.snp.bottom).offset(2)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOpacity = 0.1
    }
    
}
