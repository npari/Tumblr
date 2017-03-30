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
        let post = posts[indexPath.row]
        
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            
            // photos is NOT nil, go ahead and access element 0 and extract the image url string
            let imageURLString = photos[0].value(forKeyPath: "original_size.url") as? String
            
            //Extracting the image url
            //URL(string: imageUrlString!) is NOT nil, go ahead and unwrap it and assign it to imageUrl
            if let imageURL = URL(string: imageURLString!) {
                
                //assigning the url to the cell photo image view which is the UIImageView that we added to the cell
                cell.photoImageView.setImageWith(imageURL)
                
            } else {
                
            }
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
        }
        
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    

}
