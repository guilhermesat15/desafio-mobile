//
//  LoginViewController.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 14/12/21.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController:ViewController
{
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        
        //performSegue(withIdentifier: "identifierLogin", sender: nil)
        
        /*
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let movieViewController = storyBoard.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
        self.present(movieViewController, animated:true, completion:nil)
         */
        
            /*
            // Lendo os valores do campo de textos
            let userName = textUserName.text
            let userPassword = txtUserPassword.text
            
        
            // Verifica se o campo esta vazio
            if (userName?.isEmpty)! || (userPassword?.isEmpty)!
            {
                print("Usuario\(String(describing: userName)) ou Senha \(String(describing: userPassword)) esta vazio")
                displayMessage(userMessage: "Falta um dos campos obrigatórios")
                
                return
            }
            
            
            //Criar Activity Indicator
            let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            myActivityIndicator.center = view.center
            myActivityIndicator.hidesWhenStopped = false
            myActivityIndicator.startAnimating()
            view.addSubview(myActivityIndicator)
            
            
            //Enviar solicitação HTTP para realizar o login
            let myUrl = URL(string: "http://localhost:8080/api/authentication")
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let postString = ["userName": userName!, "userPassword": userPassword!] as [String: String]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                displayMessage(userMessage: "Something went wrong...")
                return
            }
            
             let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                if error != nil
                {
                    self.displayMessage(userMessage: "Não está sendo possível conectar com o servidor!")
                    print("error=\(String(describing: error))")
                    return
                }
                
                //Converte Json para NSDictionary
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        if parseJSON["errorMessageKey"] != nil
                        {
                             self.displayMessage(userMessage: parseJSON["errorMessage"] as! String)
                            return
                        }
                        
                        // Rebendo o Token de acesso e a Id do usuario
                        let accessToken = parseJSON["token"] as? String
                        let userId = parseJSON["id"] as? String
                        print("token de acesso: \(String(describing: accessToken!))")
                        
                        let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                        let saveUserId: Bool = KeychainWrapper.standard.set(userId!, forKey: "userId")
                        
                        print("O resultado de salvamento do token de acesso: \(saveAccesssToken)")
                        print("O resultado do salvamento do userId \(saveUserId)")
                        
                        if (accessToken?.isEmpty)!
                        {
                            self.displayMessage(userMessage: "Não foi possível realizar esta solicitação com sucesso. Por favor, tente novamente mais tarde!")
                            return
                        }
                        
                        DispatchQueue.main.async
                        {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let movieViewController = storyBoard.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
                            self.present(movieViewController, animated:true, completion:nil)
                        }
                        
                        
                    } else {

                        self.displayMessage(userMessage: "Não foi possível realizar esta solicitação com sucesso. Por favor, tente novamente mais tarde")
                    }
                    
                } catch {
                    
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    
                    self.displayMessage(userMessage: "Não foi possível realizar esta solicitação com sucesso. Por favor, tente novamente mais tarde")
                    print(error)
                }
                
             }
            task.resume()
             
             */
             
            
        }
        
        @IBAction func registerUserButtonTapped(_ sender: Any) {
            print("Registrar usuario")

            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let registerUserViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
            self.present(registerUserViewController, animated:true, completion:nil)
            
        }
        
        func displayMessage(userMessage:String) -> Void {
            DispatchQueue.main.async
                {
                    let alertController = UIAlertController(title: "Atenção", message: userMessage, preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        DispatchQueue.main.async
                            {
                                self.dismiss(animated: true, completion: nil)
                        }
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
            }
        }
        
        func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
        {
            DispatchQueue.main.async
                {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
            }
        }
    
}


