//
//  ViewController.swift
//  Project 3
//
//  Created by admin on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timeRemain: UILabel!
    @IBOutlet weak var startStop: UIButton!
    
    let arrayDays:[String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let arrayMonths:[String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "sep", "Oct", "Nov", "Dec"]
    
    var dateHolder = ""
    var timeLeftInt = 0
    var timeLeft = ""
    var timer: Timer? = nil
    var musicTimer = 0
    var state = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDate()
        loadTime()
    }
    fileprivate func loadTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let currentTime = dateFormatter.string(from: date)
            let currentTimeString = String(currentTime)
            self.timeLabel.text! = self.dateHolder + " " + currentTimeString
            
            let hour = Calendar.current.component(.hour, from: Date())
            switch hour {
            case 0...8:
                self.background.image = UIImage(named: "night_background")
            default:
                self.background.image = UIImage(named: "day_background")
            }
        }
    }
    
    fileprivate func loadDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let monthStr = self.arrayMonths[month - 1]
        let year = calendar.component(.year, from: date)
        let dayInt = Calendar.current.component(.weekday, from: Date())
        let daySpelt = self.arrayDays[dayInt - 1]
        var daySpeltString = String(daySpelt)
        var dayString = String(day)
        var yearString = String(year)
        let currentDate = daySpeltString + ", " + dayString + " " + monthStr + " " + yearString
        let currentDateString = String(currentDate)
        self.timeLabel.text! = currentDate
        dateHolder = currentDateString
    }
    
    
    @IBAction func startstopButton(_ sender: UIButton) {
        if state == 0 {
           // startStop.setTitle("Stop Timer", for: .normal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let pickerTime = dateFormatter.string(from: timePicker.date)
            self.timeRemain.text = "Time Remaining: " + pickerTime
            
            let timeInterval = timePicker.date.timeIntervalSince1970
            timeLeftInt = Int(timeInterval)
            state = 1
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        }
        else {
            self.timeRemain.text = "Time Remaining: 00:00:00"
           // self.startStop.setTitle("Start Timer", for: .normal)
            timer = nil
            state = 0
        }
    }
        
    @objc func startTimer() {
        if timeLeftInt >= 0 && state == 1 {
            let timeInterval = TimeInterval(timeLeftInt)
            let newDate = Date(timeIntervalSince1970: timeInterval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let newDateString = dateFormatter.string(from: newDate)
            self.timeRemain.text = "Time Remaining: " + newDateString
            timeLeftInt += -1
        }
        else if state == 1 {
            self.startStop.setTitle("Stop Music", for: .normal)
            musicTimer = 10
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startMusic), userInfo: nil, repeats: true)
            
        }
    }
    
    @objc func startMusic() {
        if musicTimer >= 0 {
            
        }
        else {
            timer = nil
        }
    }
}

