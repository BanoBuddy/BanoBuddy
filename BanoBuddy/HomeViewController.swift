//
//  HomeViewController.swift
//  BanoBuddy
//
//  Created by Jianyi Gao 高健一 on 3/20/17.
//  Copyright © 2017 BanoBuddy. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var bathrooms:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 315
        
        /*
        self.post(image: #imageLiteral(resourceName: "hub"), user: PFUser.current()!, description: "The Upstairs of the 2nd Floor of the Hub", rating: 4, location: CLLocationCoordinate2D(latitude: 29.648178, longitude: -82.345767)) { (success: Bool, error: Error?) in
            print("HUB")
        }
        
        self.post(image: #imageLiteral(resourceName: "marston"), user: PFUser.current()!, description: "The Basement of Marston Science Library", rating: 5, location: CLLocationCoordinate2D(latitude: 29.648109, longitude: -82.343895)) { (success: Bool, error: Error?) in
            print("MARSTON")
        }*/
        
        // construct PFQuery
        let query = PFQuery(className: "Bathroom")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (query: [PFObject]?, error: Error?) in
            if let query = query{
                // do something with the data fetched
                print ("Data fetched!")
                self.bathrooms = query
                self.tableView.reloadData()
            } else {
                // handle error
                print (error?.localizedDescription as Any)
            }
            
        }
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BathroomCell", for: indexPath) as! BathroomCell
        let bathroom = self.bathrooms[indexPath.row]
        print (self.bathrooms[indexPath.row])
        
        
        cell.descriptionLabel.text = bathroom["description"] as! String?
        
        let location = bathroom["location"] as? NSDictionary
        let lat = location?["lat"]
        let long = location?["long"]
        cell.tagLabel.text = "lat: \(lat!) long: \(long!)"
        
        cell.ratingLabel.text = String(describing:bathroom["rating"])
        
        if let file = bathroom["thumbnail"]   {
            (file as AnyObject).getDataInBackground(block: { (imageData: Data?, error: Error?) in
                if error == nil {
                    if let imageData = imageData {
                        var image = UIImage(data:imageData)
                        image = self.resize(image: image!, newSize: cell.thumbNail.frame.size)
                        cell.thumbNail.image = image
                    }
                }
            })
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bathrooms.count
    }
    
    func post(image: UIImage, user: PFUser, description: String, rating: Int, location: CLLocationCoordinate2D, withCompletion completion: PFBooleanResultBlock?)  {
        // Create Parse object PFObject
        let post = PFObject(className: "Bathroom")
        
        // Add relevant fields to the object
        post["thumbnail"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = user // Pointer column type that points to PFUser
        post["description"] = description
        post["rating"] = rating
        
        let location : [String:Double] = [
            "lat": location.latitude,
            "long": location.longitude
        ]
        
        post["location"] = location
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
