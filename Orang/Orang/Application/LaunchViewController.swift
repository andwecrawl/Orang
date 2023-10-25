//
//  LaunchViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/25.
//
import UIKit

class LaunchViewController: BaseViewController, MoveToFirstScene {
    
    let bgView = UIImageView(image: UIImage(named: "gradientbg.png"))
    
    let imageView = UIImageView(frame: .zero)
    let orangLabel = {
        let label = UILabel()
        label.text = "Orang"
        label.textColor = .white
        label.font = Design.Font.changwon.getFonts(size: 60)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 8
        label.layer.shadowOpacity = 0.1
        return label
    }()
    
    
    let imageArray: [UIImage] = [UIImage(named: "Doggo_1.png")!, UIImage(named: "Doggo_2.png")!, UIImage(named: "Doggo_3.png")!]
    var currentIndex = 0
    
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageArray[currentIndex]
        
        // 타이머 설정
        timer = Timer.scheduledTimer(timeInterval: 0.16, target: self, selector: #selector(updateImageView), userInfo: nil, repeats: true)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        configureBackground()
        
        let blur = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blur)
        visualEffectView.frame = self.view.frame
        view.addSubview(visualEffectView)
        view.addSubview(imageView)
        view.addSubview(orangLabel)
    }
    
    func configureBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.systemRed.cgColor]
        view.layer.addSublayer(gradientLayer)
        
    }
    
    override func setConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(60)
            make.size.equalTo(240)
        }
        
        
        orangLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    override func configureView() {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 8
        imageView.layer.shadowOpacity = 0.1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.moveToFirstScene()
        }
        
    }
    
    
    
    
    @objc func updateImageView() {
        // 다음 이미지로 이동
        currentIndex = (currentIndex + 1) % imageArray.count
        imageView.image = imageArray[currentIndex]
    }
    
}
