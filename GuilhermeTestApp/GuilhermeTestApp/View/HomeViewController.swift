//
//  HomePageViewController.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 14/12/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate
{
    
    @IBOutlet weak var tableViewHome: UITableView!
    
    var MacProds = ["iPhone","iPad","MacBook Pro","MacBook Air","iMac","MacPro"]
    var Intro = ["Detalhe 1","Detalhe 2","Detalhe 3","Detalhe 4","Detalhe 5","Detalhe 6"]
    var prodImage = [UIImage(named: "logo-CIT-RGB"), UIImage(named: "logo-CIT-RGB"), UIImage(named: "logo-CIT-RGB"), UIImage(named: "logo-CIT-RGB"), UIImage(named: "logo-CIT-RGB"), UIImage(named: "logo-CIT-RGB") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        makeGetCall()

        tableViewHome.dataSource = self
        tableViewHome.delegate = self
        tableViewHome.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDadosProduto() -> Void {
        self.tableViewHome.reloadData()
    }
    
    func makeGetCall() {
      // Set up the URL request
      let todoEndpoint: String = "https://api.themoviedb.org/3/movie/popular?api_key=4095e12b49ba2a56675435ca2ae84ddc&language=en-US&page=1"
      guard let url = URL(string: todoEndpoint) else {
        print("Error: cannot create URL")
        return
      }
      let urlRequest = URLRequest(url: url)

      // set up the session
      let config = URLSessionConfiguration.default
      let session = URLSession(configuration: config)

      // make the request
      let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        // check for any errors
        guard error == nil else {
          print("error calling GET on /todos/1")
          print(error!)
          return
        }
        // make sure we got data
        guard let responseData = data else {
          print("Error: did not receive data")
          return
        }
        // parse the result as JSON, since that's what the API provides
        do {
          guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
            as? [String: Any] else {
              print("error trying to convert data to JSON")
              return
          }
          // now we have the todo
          // let's just print it to prove we can access it
          print("The todo is: " + todo.description)

          // the todo object is a dictionary
          // so we just access the title using the "title" key
          // so check for a title and print it if we have one
          guard let todoTitle = todo["title"] as? String else {
            print("Could not get todo title from JSON")
            return
          }
          print("The title is: " + todoTitle)
        } catch  {
          print("error trying to convert data to JSON")
          return
        }
      }
      task.resume()
    }
    
}

extension HomeViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MacProds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoCell", for: indexPath) as! ProdutoTableViewCell

        
        cell.lblNameProduto.text? = MacProds[indexPath.row]
        cell.lblInfo.text? = Intro[indexPath.row]
        cell.imgProduto.image = prodImage[indexPath.row]
        
        cell.imgProduto.layer.cornerRadius = cell.imgProduto.frame.height / 2
        cell.imgProduto.clipsToBounds = true
        return cell
        
    }
    
    
}
