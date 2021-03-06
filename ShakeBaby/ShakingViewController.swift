//
//  ShakingViewController.swift
//  ShakeBaby
//
//  Created by steven.chou on 2017/6/10.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class ShakingViewController: UIViewController, runTimerDelegate {
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var shakeCountLabel: UILabel!

    let motionManager = CMMotionManager()
    var timer = Timer()
    var totalTime = 3
    var shakeCount = 0
    let deviceID = "\(UIDevice.current.identifierForVendor!.uuidString)"

    override func viewDidLoad() {
        super.viewDidLoad()
        let connetVC = ConnectionViewController()
        connetVC.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    func runTimer() {

        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)

    }

    func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            shakeCountLabel.text = "\(totalTime)"
        }
        if totalTime <= 0 {
            timer.invalidate()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            postResults()

        }

    }

    func postResults() {
        guard let score = shakeCountLabel.text else { return }
        let userName = UIDevice.current.name

        print(userName)
        print(score)
        guard let url = URL(string: "https://wuduhren.com/fap/register.php?id=\(deviceID)&score=\(score)&userName=\(userName)") else {
            print("wrong url")
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        //request.httpBody = deviceID.data(using: .utf8)
    }
    
}
