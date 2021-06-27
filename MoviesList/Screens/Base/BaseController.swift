
import UIKit
import NVActivityIndicatorView

class BaseController: UIViewController {
    
    //MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: - ViewController Methods
    override func loadView() {
        super.loadView()
        //* Disabling swipe back gesture *//
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //* Make default settings for nav bar *//
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //* Update status bar style *//
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
}

//MARK: - Utility Methods
extension BaseController {
    @objc func addBackButton(){
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "backarrow"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapBackButton))
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func addDoneButton(){
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapDoneButton))
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


//MARK: - Tap Handlers
extension BaseController {
    @objc func didTapBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDoneButton(){
        navigationController?.popViewController(animated: false)
    }
}


//MARK: - Activity Indicator Handling
extension BaseController: NVActivityIndicatorViewable {
    
    func startLoading(){
        let size = CGSize(width: 60, height: 60)
        startAnimating(size, message: "Loading", type: NVActivityIndicatorType.ballSpinFadeLoader)
    }
    
    func stopLoading(){
        stopAnimating()
    }
}
