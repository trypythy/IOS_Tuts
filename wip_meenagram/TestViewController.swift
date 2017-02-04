//
//  TestViewController.swift
//  wip_meenagram
//
//

import UIKit
import Firebase


class TestViewController: UIViewController {

    var storageRef: FIRStorageReference!
    var databaseRef: FIRDatabaseReference!
    
    @IBOutlet weak var storageImageView: UIImageView!
    @IBOutlet weak var storageLoadText: UILabel!
    
    @IBOutlet weak var databaseLoadText: UILabel!
    @IBOutlet weak var databaseImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storageRef = FIRStorage.storage().reference()
        databaseRef = FIRDatabase.database().reference()
        

    }
    
    func loadFromSDWebImage(){
        let sdStartTime = NSDate.timeIntervalSinceReferenceDate
        if let userID = FIRAuth.auth()?.currentUser?.uid{
            print(userID)
            let refToImage = "https://firebasestorage.googleapis.com/v0/b/meenagram-ac342.appspot.com/o/Grumpy_Cat.jpg?alt=media&token=5a5f2ac9-708e-4a31-a4d2-9e3a1eb33447"
        
            storageImageView.sd_setImage(with: URL(string: refToImage))
        
            let sdEndTime = NSDate.timeIntervalSinceReferenceDate
        
            let sdDelta = sdEndTime - sdStartTime
        
            storageLoadText.text = "\(sdDelta)"
        }
    }
    
    func loadFromDatabaseURL(){
        
        let dbStartTime = NSDate.timeIntervalSinceReferenceDate
        
        let databaseStartTime = NSDate.timeIntervalSinceReferenceDate
        
        if let userID = FIRAuth.auth()?.currentUser?.uid{
            
            databaseRef.child("profile").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let dictionary = snapshot.value as? NSDictionary
                
                if let profileImageURL = dictionary?["photo"] as? String{
                    
                    let url = URL(string: profileImageURL)
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async {
                            self.databaseImageView.image = UIImage(data: data!)
                            let databaseEndTime = NSDate.timeIntervalSinceReferenceDate
                            
                            let databaseTotalTimeInterval = databaseEndTime - databaseStartTime
                            self.databaseLoadText.text = "\(databaseTotalTimeInterval)"
                        }
                    }).resume()
                }
            }) { (error) in
                print(error.localizedDescription)
                return
            }
            
        }

        
        let dbEndTime = NSDate.timeIntervalSinceReferenceDate
        
        let dbDelta = dbEndTime - dbStartTime
        
        databaseLoadText.text = "\(dbDelta)"
        
    }
    @IBAction func runText(_ sender: Any) {
        loadFromDatabaseURL()
        loadFromSDWebImage()
    }

}
