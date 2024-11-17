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
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var thermosName: UILabel!
    @IBOutlet weak var tempBar: UIView!
    @IBOutlet weak var unitAlterBtn: UISegmentedControl!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var tempNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var thermoListBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var alarmTableView: UITableView!
    
    
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
            maxTempLabel.text = "100"
            currentTempLabel.text = String(Int(temp))

        // fah
        case 1:
            updateTempBarAppearance(emptyColour: UIColor(red: 193/255, green: 195/255, blue: 255/255, alpha: 1.0).cgColor,
                         filledColour: UIColor(red: 99/255, green: 112/255, blue: 255/255, alpha: 1.0).cgColor)
            setProgress(for: temp, for: 212)
            maxTempLabel.text = "212"
            currentTempLabel.text = String(Int(celToFah(for: temp)))
        default:
            break
        }
    }
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setProgress(for: temp, for: 100)
        tableViewRegsiter()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        setupMinTempLabel()
        setupMaxTempLabel()
        setuptempNameLabel()
        setupCurrentTempLabel()
        setupButtomView()
        setupHomeBtn()
        setupThermoListBtn()
        setupSettingBtn()
        setupAlarmLabel()
        setupAlarmTableView()
    }
    
    private func tableViewRegsiter() {
        alarmTableView.delegate = self
        alarmTableView.dataSource = self
        
        let alarmNib = UINib(nibName: "AlarmTableViewCell", bundle: nil)
        alarmTableView.register(alarmNib, forCellReuseIdentifier: "AlarmTableViewCell")
    }
    
    private func setupAlarmTableView() {
        alarmTableView.backgroundColor = .none
    }
    
    private func setupAlarmLabel () {
        alarmLabel.text = "알림 / 경고"
        alarmLabel.font = UIFont.boldSystemFont(ofSize: 16)
        alarmLabel.sizeToFit()
    }
    
    private func setupHomeBtn () {
        homeBtn.setImage(UIImage(named: "homeSelected"), for: .normal)
        homeBtn.setTitle("", for: .normal)
    }
    
    private func setupThermoListBtn () {
        thermoListBtn.setImage(UIImage(named: "thermoList"), for: .normal)
        thermoListBtn.setTitle("", for: .normal)
    }
    
    private func setupSettingBtn () {
        settingBtn.setImage(UIImage(named: "setting"), for: .normal)
        settingBtn.setTitle("", for: .normal)
    }
    
    // 온도 변환 C -> F
    private func celToFah(for currentTemp : Float ) -> Float {
        return currentTemp * 9/5 + 32
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

    private func setupButtomView() {
        let cornerRadius: CGFloat = 40
        let maskPath = UIBezierPath(roundedRect: bottomView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        bottomView.layer.mask = shape
    }
    
    private func setupMinTempLabel(){
        minTempLabel.text = "0"
        minTempLabel.sizeToFit()
    }
    
    private func setupMaxTempLabel(){
        maxTempLabel.text = "100"
        maxTempLabel.sizeToFit()
    }
    
    private func setuptempNameLabel() {
        tempNameLabel.text = "현재온도"
        tempNameLabel.textColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1.0)
        tempNameLabel.font = UIFont(name: "Nil", size: 16)
        tempNameLabel.sizeToFit()
    }
    
    private func setupCurrentTempLabel() {
        currentTempLabel.text = String(Int(temp))
        currentTempLabel.textColor = UIColor(red: 63/255, green: 63/255, blue: 63/255, alpha: 1.0)
        currentTempLabel.font = UIFont.boldSystemFont(ofSize: 70)
        currentTempLabel.sizeToFit()
    }
    
   

    private func setupConstraints() {
        businessName.translatesAutoresizingMaskIntoConstraints = false
        alarmBtn.translatesAutoresizingMaskIntoConstraints = false
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        thermosName.translatesAutoresizingMaskIntoConstraints = false
        tempBar.translatesAutoresizingMaskIntoConstraints = false
        unitAlterBtn.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        homeBtn.translatesAutoresizingMaskIntoConstraints = false
        thermoListBtn.translatesAutoresizingMaskIntoConstraints = false
        settingBtn.translatesAutoresizingMaskIntoConstraints = false
        alarmLabel.translatesAutoresizingMaskIntoConstraints = false
        alarmTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // alarmTableView 제약 설정
        NSLayoutConstraint.activate([
            alarmTableView.leadingAnchor.constraint(equalTo: alarmLabel.leadingAnchor),
            alarmTableView.topAnchor.constraint(equalTo: alarmLabel.bottomAnchor, constant: 15),
            alarmTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -25),
            alarmTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30)
        ])
        
        
        // alarmLabel 제약 설정
        NSLayoutConstraint.activate([
            alarmLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 25),
            alarmLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30)
        ])
        
        // homeBtn 버튼 제약 설정
        NSLayoutConstraint.activate([
            homeBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            homeBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10)
        ])

        // homeBtn 버튼 제약 설정
        NSLayoutConstraint.activate([
            thermoListBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            thermoListBtn.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
        ])
        
        // homeBtn 버튼 제약 설정
        NSLayoutConstraint.activate([
            settingBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            settingBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10)
        ])
        
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
        
        // minTempLabel 제약 설정
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -125),
            minTempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65)
        ])
        
        // maxTempLabel 제약 설정
        NSLayoutConstraint.activate([
            maxTempLabel.centerYAnchor.constraint(equalTo: minTempLabel.centerYAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55)
        ])
        
        // tempNameLabel 제약 설정
        NSLayoutConstraint.activate([
            tempNameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            tempNameLabel.topAnchor.constraint(equalTo: thermosName.bottomAnchor, constant: 100)
        ])
        
        // currentTempLabel 제약 설정
        NSLayoutConstraint.activate([
            currentTempLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 5),
            currentTempLabel.topAnchor.constraint(equalTo: tempNameLabel.bottomAnchor, constant: 1)
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


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let alarmCell = alarmTableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as? AlarmTableViewCell 
        else { return UITableViewCell() }
        
        alarmCell.backgroundColor = .white
        alarmCell.layer.cornerRadius = 15
        alarmCell.layer.masksToBounds = true
        tableView.separatorStyle = .none

        return alarmCell
    }
}
