//
//  MovieDetailsViewController.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 16/12/21.
//

import UIKit

class MovieDetailsViewController: UIViewController
{
    
    @IBOutlet var productionCollectionView: UICollectionView!
    @IBOutlet var imgPoster: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblgenres: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    var idMovie = Int()
    
    var movieDetails = [MovieDetail]()
    var productionCompanys = [ProductionCompany]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Criar Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)


        MovieDetailsViewModel().fetchMovieDetails { [weak self] (movieDetails) in
          self?.movieDetails = movieDetails
            
            var Movi = movieDetails[0]
            
            print(Movi.posterPath)
            self?.imgPoster.load(url:URL(string:UrlTmdb.init().endPointImage + Movi.posterPath)!)
            self?.lblTitle.text = Movi.title
            self?.lblDescription.text = Movi.overview
            self?.lblYear.text = Date.getFormattedDate(string: Movi.releaseDate, formatter: "yyyy")
            self?.lblTime.text = String(Movi.runtime)
            
            var genre=""
            for item in Movi.genres {
                genre = genre + "," + item.name
            }
            self?.lblgenres.text = genre
            self?.productionCompanys = Movi.productionCompanies
            
          DispatchQueue.main.async {

              self?.productionCollectionView.reloadData()
              self?.removeActivityIndicator(activityIndicator: myActivityIndicator)
          }
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

extension MovieDetailsViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(productionCompanys.count)
        return productionCompanys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "productionCompanyCollectViewCell",
            for: indexPath
          ) as! ProductionCompanyCollectViewCell

        var productions = productionCompanys[indexPath.row]
        cell.imgProduction.load(url:URL(string:UrlTmdb.init().endPointImage + "/PzJdsLGlR7oW4J0J5Xcd0pHGRg.png")!)

          return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 128, height: 218)
    }
    
    
}




/*
extension MovieDetailsViewController: UICollectionViewDataSource {
  // 1
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return movieDetails.ProductionCompany.count
  }
  
  // 2
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
      return movieDetails.Pro
  }
  
  // 3
  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath)
    cell.backgroundColor = .black
    // Configure the cell
    return cell
  }
}
 */

/*
extension Date {
    
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}
 */

