//
//  ProjetoFilmesTests.swift
//  ProjetoFilmesTests
//
//  Created by Genner Ramos Maia on 12/14/24.
//
import XCTest
import CoreData
@testable import ProjetoFilmes

final class ProjetoFilmesTests: XCTestCase {
    
	var context: NSManagedObjectContext!
    override func setUp()  {
       
		context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	}

    
    func testLoginSenhaCorreta()  {
        let loginVC = LoginViewController()
		let loginResultado = loginVC.validateLogin(usuario: "aluno", senha: "1234")
		XCTAssertTrue(loginResultado)
    }

	func testLoginSenhaIncorreta(){
		let loginVC = LoginViewController()
		let loginResultado = loginVC.validateLogin(usuario: "aluno", senha: "1111")
		XCTAssertFalse(loginResultado)
	}

}
