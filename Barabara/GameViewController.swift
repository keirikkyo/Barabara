//
//  GameViewController.swift
//  Barabara
//
//  Created by 吉江恵 on 2024/05/10.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var timer: Timer!
    var score: Int = 1000
    let saveData: UserDefaults = UserDefaults.standard
    let width: CGFloat = UIScreen.main.bounds.size.width
    var posintionX: [CGFloat] = [0.0, 0.0, 0.0]
    var dx: [CGFloat] = [1.0, 0.5, -1.0]
    
    func start() {
        resultLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
    }
    
    @objc func up() {
        for i in 0..<3 {
            if posintionX[i] > width || posintionX[i] < 0 {
                dx[i] = dx[i] * -1
            }
            posintionX[i] += dx[i]
        }
        imageView1.center.x = posintionX[0]
        imageView2.center.x = posintionX[1]
        imageView3.center.x = posintionX[2]
    }
    
    @IBAction func stop() {
        if timer.isValid == true {
            timer.invalidate()
        }
        
        for i in 0..<3 {
            score = score - abs(Int(width/2 - posintionX[i])) * 2
        }
        resultLabel.text = "Score:　" + String(score)
        resultLabel.isHidden = false
        
        let highScore1: Int = saveData.integer(forKey: "score1")
        let highScore2: Int = saveData.integer(forKey: "score2")
        let highScore3: Int = saveData.integer (forKey: "score3")
        
        if score > highScore1 {
            saveData.set(score, forKey: "score1")
            saveData.set(highScore1, forKey: "score2")
            saveData.set(highScore2, forKey: "score3")
        } else if score > highScore2 {
            saveData.set(score, forKey: "score2")
            saveData.set(highScore2, forKey: "score3")
        } else if score > highScore3 {
            saveData.set(score, forKey: "score3")
        }
    }
    @IBAction func retry() {
        score = 1000
        posintionX = [width/2, width/2, width/2]
        if timer.isValid == false {
            self.start()
        }
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        posintionX = [width/2, width/2, width/2]
        
        self.start()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
