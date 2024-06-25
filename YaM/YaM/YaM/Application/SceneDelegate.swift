import UIKit
import FirebaseAuth

// MARK: - Легенда
/// -----------
/// refme
/// fixme
/// delme
/// checkme
/// -----------

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setWindow(scene: scene)
        checkAuth(vc: LoginViewController(), scene: true)
    }
    
    private func setWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }
    public func checkAuth(vc: UIViewController, scene: Bool) {
        guard let user = Auth.auth().currentUser else { 
            self.transitTo(rootViewController: vc)
            return
        }
        DispatchQueue.main.async {
            user.reload { _ in
                
                switch user.isEmailVerified {
                case true:
                    self.transitTo(rootViewController: MapViewController())
                case false:
                    self.transitTo(rootViewController: vc)
                    
                    if !scene {
                        Src.showNotConfirmeddAlert(vc: vc)
                    }
                }
            }
        }
    }
    private func transitTo(rootViewController: UIViewController) {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = nav
    }
    
    /*
    private func goToViewController(viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                    
                }
            }
        }
    }
    */

}

