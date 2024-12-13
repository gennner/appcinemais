
import UIKit
import CoreData
class CadastroViewController:UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	@IBOutlet weak var capaImageView: UIImageView!
	
	@IBOutlet weak var tituloTextField: UITextField!
	@IBOutlet weak var generoTextField: UITextField!
	@IBOutlet weak var duracaoTextField: UITextField!
	@IBOutlet weak var anoTextField: UITextField!
	@IBOutlet weak var origemTextField: UITextField!
	
	@IBOutlet weak var diretorTextField: UITextField!
	
	let context = (UIApplication.shared.delegate as!
				   AppDelegate).persistentContainer.viewContext
	var filmeEditar: Filmes?
	override func viewDidLoad() {
		super.viewDidLoad()
		setupEditar()
	}
	func setupEditar(){
		if let filme = filmeEditar{
			capaImageView.image = UIImage(data: filme.capa!)
			tituloTextField.text = filme.titulo
			diretorTextField.text = filme.diretor
			generoTextField.text = filme.genero
			origemTextField.text = filme.origem
			duracaoTextField.text = String(filme.duracao)
			anoTextField.text = String(filme.ano)
		}
	}
	
	
	@IBAction func salvarButton(_ sender: UIButton) {
		
		if let filme = filmeEditar{
			editarFilme(filme)
		}//end if
		else{
			criarFilme()
		}//end else
	} //end IBAction
	
		func criarFilme(){
			let novoFilme = Filmes(context: context)
			preencherFilme(novoFilme)
			do
			{ try context.save()
				navigationController?.popViewController(animated: true) }catch
			{ AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Erro ao criar Filmes")
				}//end try
		}//end begin
		
		func editarFilme(_ filme: Filmes){
			preencherFilme(filme)
			do{ try context.save()
				navigationController?.popViewController(animated: true) }
			catch{ AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Erro ao editar Filmes")
			} //end catch
		} //end editarfilme
		
		func preencherFilme(_ filme: Filmes)
		{
			
			filme.titulo = tituloTextField.text
			filme.diretor = diretorTextField.text
			filme.genero = generoTextField.text
			filme.origem = origemTextField.text
			
			if let duracao = Int16(duracaoTextField.text ?? "")
			{ filme.duracao = duracao }
			
			if let ano = Int16(anoTextField.text ?? "")
			{ filme.ano = ano }
			
			filme.capa = capaImageView.image?.pngData()
			
		}//end func preencherFilme
		
		
	@IBAction func galeriaButton(_ sender: UIButton) {
		
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker,animated: true,completion: nil)
	}
	
	func imagePickerController(_ picker:UIImagePickerController,
							  didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
		if let imagemSelecionada = info[.originalImage] as? UIImage{
			capaImageView.image = imagemSelecionada
			
		}
		picker.dismiss(animated: true,completion: nil)
	}
	
}
	

