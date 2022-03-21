//
//  ViewController.swift
//  FlickrAssignment
//
//  Created by admin on 11/03/2022.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var networkManager : flickrNetworkClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.dataSource = self
        //networkManager(ViewController: self)
        networkManager = flickrNetworkClass(viewController: self)
        

        //networkManager.getImage()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let text = searchBar.text {
                networkManager.getImage(search: text)
            }
        }
    
    
    
    


}

extension ViewController: UICollectionViewDataSource,  UICollectionViewDelegate{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let flickrCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCell", for: indexPath) as! FlickrViewCell
        let user = networkManager.data[indexPath.row]
        
        let farmValue = user.farm
        let server = user.server
        let id = user.id
        let secretValue = user.secret
        
        let imageReturnedURL = "https://farm\(farmValue).staticflickr.com/\(server)/\(id)_\(secretValue)_m.jpg"
        
        flickrCell.flickrImage.downLoadImage(owner: imageReturnedURL)

        //https://farm2.staticflickr.com/1704/25180682049_0c83b86b32_m.jpg

        
        return flickrCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = networkManager.data[indexPath.row]
        let image = Image(context: self.context)
        
        image.farmValue = Int64(user.farm)
        image.server = user.server
        image.id = user.id
        image.secretValue = user.secret
        image.url = "https://farm\(user.farm).staticflickr.com/\(user.server)/\(user.id)_\(user.secret)_m.jpg"
        do{
            try self.context.save()
            print("Image saved")
            
            }
        catch{print(error.localizedDescription)
        }
        
    }
    
        
    
    
    
    
    
    
    
    
}

protocol Result: AnyObject{
    
    func getFinalResult()
}

extension ViewController: Result{
    
    func getFinalResult() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
    
    
}


