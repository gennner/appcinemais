import UIKit
class AlertHelper{
static func showAlert(on viewController: UIViewController, titulo: String, mensagem: String){
let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
alert.addAction(okAction)
viewController.present(alert, animated: true, completion: nil)
}
}
