import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var splashImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSplashImage()
        setupGradientLayer()
        setupLabel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.transitionToHomeViewController()
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
