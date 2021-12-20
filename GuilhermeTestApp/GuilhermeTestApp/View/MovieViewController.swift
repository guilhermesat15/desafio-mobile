//
//  MovieViewController.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 16/12/21.
//



import UIKit

class MovieViewController: UIViewController
{
    
    @IBOutlet weak var tableViewMovie: UITableView!
    @IBOutlet weak var segType: UISegmentedControl!
    @IBOutlet weak var searchBarMovie:UISearchBar!
    var indexMovie:Int = 0
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movie"
        tableViewMovie.dataSource = self
        tableViewMovie.delegate = self

        MoviePupularViewModel().fetchFilms { [weak self] (movies) in
          self?.movies = movies
          DispatchQueue.main.async {
            self?.tableViewMovie.reloadData()
          }
        }
    }

    @IBAction func segTypeChanged(_ sender: Any) {
        
        if segType.selectedSegmentIndex == 0 {
            
            MoviePupularViewModel().fetchFilms { [weak self] (movies) in
              self?.movies = movies
              DispatchQueue.main.async {
                self?.tableViewMovie.reloadData()
              }
            }
        
        } else if segType.selectedSegmentIndex == 1 {
            
            MoviePupularViewModel().fetchFilms { [weak self] (movies) in
              self?.movies = movies
              DispatchQueue.main.async {
                self?.tableViewMovie.reloadData()
              }
            }
        }
    }
    

    
    func formatToQueryString(_ string: String) -> String {
        return string.components(separatedBy: " ").joined(separator: "%20")
    }
    
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MovieTableViewCell
        
        if movies.isEmpty {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
            
            let movie = movies[indexPath.row]
              
            cell.lblTitle.text = movie.title
            cell.lblReleaseDate.text = Date.getFormattedDate(string: movie.releaseDate, formatter: "MMM dd,yyyy")
            
            cell.imgPosterPath.load(url:URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")!)
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexMovie = indexPath.row
        performSegue(withIdentifier: "identifierLogin", sender: nil)
        
        /*
        let selectedTrail = movies[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let movieViewController =  storyBoard.instantiateViewController(withIdentifier: "movieDetailsViewController") as! MovieDetailsViewController
        movieViewController.idMovie = selectedTrail.id
        self.present(movieViewController, animated:true, completion:nil)
         */
            
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        if identifier == "identifierDetail" {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "identifierDetail" {
             let vc = segue.destination as! MovieDetailsViewController
            print(indexMovie)
            let movie = movies[indexMovie]
            vc.idMovie = movie.id
        }
    }
    
}



extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!))
        return dateFormatterPrint.string(from: date!);
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
