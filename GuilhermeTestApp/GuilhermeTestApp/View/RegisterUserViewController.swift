//
//  RegisterUserViewController.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 14/12/21.
//

import UIKit

class RegisterUserViewController: UIViewController
{
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

        @IBAction func cancelButtonTapped(_ sender: Any) {
            print("Cancel button tapped")
            
            self.dismiss(animated: true, completion: nil)
        }
        
        
        @IBAction func signupButtonTapped(_ sender: Any) {
            print("Sign up button tapped")
            
            // Validate required fields are not empty
            if (txtUserName.text?.isEmpty)! ||
                (txtUserName.text?.isEmpty)! ||
                (txtUserEmail.text?.isEmpty)! ||
                (txtUserPassword.text?.isEmpty)! ||
                (txtUserPassword.text?.isEmpty)!
            {
                // Display Alert message and return
                displayMessage(userMessage: "All fields are quired to fill in")
                return
            }
            
                        
            //Create Activity Indicator
            let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            
            // Position Activity Indicator in the center of the main view
            myActivityIndicator.center = view.center
            
            // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
            myActivityIndicator.hidesWhenStopped = false
            
            // Start Activity Indicator
            myActivityIndicator.startAnimating()
            
            view.addSubview(myActivityIndicator)
            
            
            // Send HTTP Request to Register user
            let myUrl = URL(string: "http://localhost:8080/api/users")
            var request = URLRequest(url:myUrl!)
            request.httpMethod = "POST"// Compose a query string
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let postString = ["firstName": txtUserName.text!,
                              "email": txtUserEmail.text!,
                              "password": txtUserPassword.text!,
                              ] as [String: String]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                displayMessage(userMessage: "Something went wrong. Try again.")
                return
            }
            
         let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    
                    let userId = parseJSON["userId"] as? String
                    print("User id: \(String(describing: userId!))")
                    
                    if (userId?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    } else {
                        self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
                    }
                    
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
            } catch {
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
            }
            
            task.resume()
            
        }
        
            
            
          func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
            {
                DispatchQueue.main.async
                 {
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                }
            }
            
        
        func displayMessage(userMessage:String) -> Void {
            DispatchQueue.main.async
                {
                    let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        // Code in this block will trigger when OK button tapped.
                        print("Ok button tapped")
                        DispatchQueue.main.async
                            {
                                self.dismiss(animated: true, completion: nil)
                        }
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
            }
        }
}

