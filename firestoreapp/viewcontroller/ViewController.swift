//
//  ViewController.swift
//  firestoreapp
//
//  Created by Evgenii Shiltsev on 21.2.2020.
//  Copyright © 2020 Evgenii Shiltsev. All rights reserved.
//

import UIKit
import Firebase
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  let db = Firestore.firestore()
        //db.collection("wine").addDocument(data: ["year":2017, "type":"alazanka", "label":"georgia"])
       // let newDocument = db.collection("wine").document()
       // newDocument.setData(["year":2015, "type":"orange","label":"national","id":newDocument.documentID])
        /*db.collection("wine").addDocument(data: ["test":"test"]) { (error) in
            
            if let error = error {
                
            }
            else if{
                
            }
        }
    */
        
        
    setUpElements()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
        
    }
    func setUpElements(){
        Utilities.styleFilledButton(signupButton)
        Utilities.styleFilledButton(loginButton)

}
    func setUpVideo(){
       let bundlePath =  Bundle.main.path(forResource: "video", ofType: "mp4")
        
        guard bundlePath != nil else{
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 1)
        
    }

}
