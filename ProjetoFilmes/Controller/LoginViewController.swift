import UIKit
import CoreData
class LoginViewController: UIViewController{
@IBOutlet weak var usuarioTextField: UITextField!
@IBOutlet weak var senhaTextField: UITextField!
override func viewDidLoad() {
super.viewDidLoad()
createUser()
}
@IBAction func entrarButton(_ sender: UIButton) {
guard let usuario = usuarioTextField.text, let senha = senhaTextField.text else{
return
}
if validateLogin(usuario: usuario, senha: senha){
performSegue(withIdentifier: "FilmesView", sender: nil)
}else{
AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Usuário ou senha incorretos")
}
}
//continua
    func createUser(){
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "usuario = %@", "aluno")
    do{
    let usuarioExistente = try context.fetch(fetchRequest)
    if usuarioExistente.isEmpty{
    let usuarioPadrao = Login(context: context)
    usuarioPadrao.id = 1
    usuarioPadrao.usuario = "aluno"
    usuarioPadrao.senha = "1234"
    try context.save()
    }
    }catch{
    AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Erro ao verificar usuarios existentes: \(error)")
    }
    }
    func validateLogin(usuario: String, senha: String) -> Bool{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "usuario = %@ AND senha = %@",usuario,senha)
    do{
    let result = try context.fetch(fetchRequest)
    return !result.isEmpty
    }catch{
    AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Erro ao validar login")
    return false
    }
    }
    }
