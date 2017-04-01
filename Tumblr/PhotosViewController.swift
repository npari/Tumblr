//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Pari, Nithya on 3/29/17.
//  Copyright © 2017 Pari, Nithya. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    //To store the results of the Tumblr API
    var posts: [NSDictionary] = []
    @IBOutlet weak var photosTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting data source and delegate for Photos Table View
        photosTableView.delegate = self
        photosTableView.dataSource = self
        
        //Set static height for photosTableView's cell
        photosTableView.rowHeight = 240

        //Calling the Tumblr API
        let tumblrURL = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: tumblrURL!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        //Creating task to call the Tumblr API and get posts
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options: []) as? NSDictionary {
                        
                        print("########responseDictionary######")
                        print("\(responseDictionary)")
                        
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        
                        //Reloading the photo table view to reflect the new data
                        self.photosTableView.reloadData()
                    }
                }
            })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Creating the custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCellTableViewCell
        
        //Extracting each post using index
        let imageURLString = getImageURL(indexPath: indexPath)
        if let imageURL = URL(string: imageURLString) {
            cell.photoImageView.setImageWith(imageURL)
        } else {
            cell.textLabel?.text = "No image for \(indexPath.row)"
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Get rid of the gray selection effect by deselecting the cell with animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! PhotoDetailsViewController
        let indexPath = photosTableView.indexPath(for: sender as! UITableViewCell)!
        
        //get image for this indexpath.row
        let imageURLString = getImageURL(indexPath: indexPath)
        if let imageURL = URL(string: imageURLString) {
            vc.imagURL = imageURL
        } else {
            
        }
    }
    
    //This method returns the url of the image for a particular row from the posts array
    func getImageURL(indexPath: IndexPath) -> String {
        let post = posts[indexPath.row]
        var imageURLString = ""
        
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            imageURLString = (photos[0].value(forKeyPath: "original_size.url") as? String)!
        }
        
        return imageURLString
    
    }
    

}
