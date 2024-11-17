import UIKit
import CoreBluetooth

class SplashViewController: UIViewController {
    @IBOutlet weak var splashImage: UIImageView!
    private var centralManager: CBCentralManager?
    private var isBluetoothAuthorized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSplashImage()
        setupGradientLayer()
        setupLabel()
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.transitionToHomeViewController()
        }
        
        initializeBluetooth()

    }
    
    private func initializeBluetooth() {
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    private func checkAndTransition() {
        if isBluetoothAuthorized {
            transitionToHomeViewController()
        }
    }
    
    
    // 이미지 설정 및 contentMode 적용
    private func setupSplashImage() {
        splashImage.image = UIImage(named: "splashView")
        splashImage.contentMode = .scaleAspectFill
        splashImage.clipsToBounds = true
    }
    
    // 그라데이션 레이어 설정
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = splashImage.bounds
        gradientLayer.colors = [
            UIColor(red: 0.89, green: 0.57, blue: 0.33, alpha: 0.5).cgColor, // E49155
            UIColor(red: 0.49, green: 0.31, blue: 0.18, alpha: 0.7).cgColor, // 7E502F
            UIColor(red: 0.49, green: 0.31, blue: 0.18, alpha: 0.9).cgColor  // 7E502F
        ]
        
        gradientLayer.locations = [0.0, 0.7, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        splashImage.layer.addSublayer(gradientLayer)
    }
    
    // 중앙에 UILabel 추가
    private func setupLabel() {
        let label = UILabel()
        label.text = "\(RootSetting.businessName)"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        splashImage.addSubview(label)
        
        // UILabel 중앙에 위치시키기 위한 Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: splashImage.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: splashImage.centerYAnchor)
        ])
    }
    
    // HomeViewController로 전환
    private func transitionToHomeViewController() {
        // let homeViewController = HomeViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        // 윈도우의 rootViewController를 변경
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }
}

extension SplashViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on")
            // 스캔 시작하여 권한 요청 트리거
            centralManager?.scanForPeripherals(withServices: nil)
            
            // 3초 후 화면 전환
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isBluetoothAuthorized = true
                self.checkAndTransition()
            }
            
        case .unauthorized:
            print("Bluetooth permission denied")
            showBluetoothPermissionAlert()
            
            // 사용자가 '취소'를 선택하더라도 3초 후 화면 전환
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isBluetoothAuthorized = true
                self.checkAndTransition()
            }
            
        case .poweredOff:
            print("Bluetooth is powered off")
            showBluetoothOffAlert()
            
            // 블루투스가 꺼져있어도 3초 후 화면 전환
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isBluetoothAuthorized = true
                self.checkAndTransition()
            }
            
        default:
            print("Bluetooth state: \(central.state)")
            // 다른 상태에서도 3초 후 화면 전환
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isBluetoothAuthorized = true
                self.checkAndTransition()
            }
        }
    }
    
    private func showBluetoothPermissionAlert() {
        let alert = UIAlertController(
            title: "블루투스 권한 필요",
            message: "이 앱을 사용하기 위해서는 블루투스 권한이 필요합니다. 설정에서 권한을 허용해주세요.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showBluetoothOffAlert() {
        let alert = UIAlertController(
            title: "블루투스가 꺼져있습니다",
            message: "블루투스를 켜주세요",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        present(alert, animated: true)
    }
}
