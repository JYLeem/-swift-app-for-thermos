//
//  HomeViewController.swift
//  -swift-thermos
//
//  Created by Jinyoung Leem on 11/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var thermosName: UILabel!
    @IBOutlet weak var tempBar: UIView!
    @IBOutlet weak var unitAlterBtn: UISegmentedControl!
    
    var thermosNickName : String = "Alpha1"
    var temp : Float = 30.0
    
    // MARK: - Actions
    @IBAction func unitAlterButtonTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        // celc
        case 0:
            updateTempBarAppearance(emptyColour: UIColor(red: 254/255, green: 219/255, blue: 195/255, alpha: 1.0).cgColor,
                                    filledColour: UIColor(red: 250/255, green: 135/255, blue: 52/255, alpha: 1.0).cgColor)
            setProgress(for: temp, for: 100)
        // fah
        case 1:
            updateTempBarAppearance(emptyColour: UIColor(red: 193/255, green: 195/255, blue: 255/255, alpha: 1.0).cgColor,
                         filledColour: UIColor(red: 99/255, green: 112/255, blue: 255/255, alpha: 1.0).cgColor)
            setProgress(for: temp, for: 212)
        default:
            break
        
        }
    }
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setProgress(for: temp, for: 100)
    }


    // MARK: - Functions
    private func setupUI(){
        setupMainView()
        setupBussinessName()
        setupAlarmBtn()
        setupProfileBtn()
        setupConstraints()
        setupThermosName()
        setupTopView()
        setupUnitAlterBtn()
        setupTempBar()
    }
    
    private func setupMainView(){
        mainView.backgroundColor = RootSetting.themeColor
    }
    
    private func updateTempBarAppearance(emptyColour: CGColor, filledColour: CGColor) {
        backgroundLayer.strokeColor = emptyColour
        progressLayer.strokeColor = filledColour
    }
    
    private func setupBussinessName(){
        businessName.text = "\(RootSetting.businessName)"
        businessName.font = UIFont.boldSystemFont(ofSize: businessName.font.pointSize)
        businessName.sizeToFit()
    }
    
    private func setupAlarmBtn(){
        alarmBtn.setImage(UIImage(named: "alarmIcon"), for: .normal)
        alarmBtn.setTitle("", for: .normal) // 타이틀을 완전히 제거
    }
    
    private func setupProfileBtn(){
        profileBtn.setImage(UIImage(named: "profilePhoto"), for: .normal)
        profileBtn.setTitle("", for: .normal)
    }
    
    private func setupThermosName() {
        thermosName.text = "인슐린 보냉용기 \(thermosNickName)"
        thermosName.sizeToFit()
    }
    
    private func setupTopView() {
        let cornerRadius: CGFloat = 40
        topView.layer.cornerRadius = 0  // 기본 cornerRadius는 0으로 설정
        topView.layer.maskedCorners = []  // 기본 설정은 빈 배열로 초기화

        // 원하는 코너에만 radius 적용
        let maskPath = UIBezierPath(roundedRect: topView.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        topView.layer.mask = shape
    }

    
    private func setupConstraints() {
        // 각 뷰의 Auto Layout 사용을 활성화합니다.
        businessName.translatesAutoresizingMaskIntoConstraints = false
        alarmBtn.translatesAutoresizingMaskIntoConstraints = false
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        thermosName.translatesAutoresizingMaskIntoConstraints = false
        tempBar.translatesAutoresizingMaskIntoConstraints = false
        unitAlterBtn.translatesAutoresizingMaskIntoConstraints = false


        // businessName 레이블 제약 설정
        NSLayoutConstraint.activate([
            businessName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            businessName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        // alarmBtn 버튼 제약 설정
        NSLayoutConstraint.activate([
            alarmBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            alarmBtn.centerYAnchor.constraint(equalTo: businessName.centerYAnchor),
            alarmBtn.widthAnchor.constraint(equalToConstant: 30),  // 버튼 크기
            alarmBtn.heightAnchor.constraint(equalToConstant: 30)
        ])

        // profileBtn 버튼 제약 설정
        NSLayoutConstraint.activate([
            profileBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileBtn.centerYAnchor.constraint(equalTo: businessName.centerYAnchor),
            profileBtn.widthAnchor.constraint(equalToConstant: 30),  // 버튼 크기
            profileBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // thermosName 레이블 제약 설정 (businessName 아래)
        NSLayoutConstraint.activate([
            thermosName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thermosName.topAnchor.constraint(equalTo: businessName.bottomAnchor, constant: 30)
        ])
                
        // unitAlterBtn 제약 설정 (mainView 위, 20pt 간격)
        NSLayoutConstraint.activate([
            unitAlterBtn.centerXAnchor.constraint(equalTo: topView.trailingAnchor, constant: -60),
            unitAlterBtn.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            unitAlterBtn.widthAnchor.constraint(equalToConstant: 50),  // unitAlterBtn의 너비
            unitAlterBtn.heightAnchor.constraint(equalToConstant: 30)  // 정사각형으로 설정
        ])
    }
    
    private func setupUnitAlterBtn() {
        unitAlterBtn.removeAllSegments()
        unitAlterBtn.insertSegment(withTitle: "°C", at: 0, animated: false)
        unitAlterBtn.insertSegment(withTitle: "°F", at: 1, animated: false)
        unitAlterBtn.selectedSegmentIndex = 0
    }


    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()

    private func setupTempBar() {
        let center = CGPoint(x: tempBar.bounds.width / 2, y: tempBar.bounds.height)
        let radius = tempBar.bounds.width / 2
        let startAngle = CGFloat.pi
        let endAngle = 2 * CGFloat.pi

        // 배경 레이어 설정
        backgroundLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        backgroundLayer.strokeColor = UIColor(red: 254/255, green: 219/255, blue: 195/255, alpha: 1.0).cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 20 // 두께 설정
        tempBar.layer.addSublayer(backgroundLayer)

        // 중간 비우기
        progressLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        progressLayer.strokeColor = UIColor(red: 250/255, green: 135/255, blue: 52/255, alpha: 1.0).cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 20 // 두께 설정
        progressLayer.strokeEnd = 0 // 초기 값
        tempBar.layer.addSublayer(progressLayer)
    }

    func setProgress(for temp: Float, for maxTemp : Float) {
        let progress = max(0, min(1, CGFloat((temp - 0) / (maxTemp - 0))))
        progressLayer.strokeEnd = progress
    }
}
