
import Foundation

protocol BaseViewModelDelegate: class {
    func showLoader()
    func hideLoader()
    func showErrorAlert(message: String)
    func showSuccessAlert(message: String)
}

extension BaseViewModelDelegate {
    
    func showLoader(){}
    func hideLoader(){}
    func showErrorAlert(message: String) {}
    func showSuccessAlert(message: String) {}
}

public class BaseViewModel {
    weak var baseDelegate: BaseViewModelDelegate?
}
