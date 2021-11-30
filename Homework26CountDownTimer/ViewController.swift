//
//  ViewController.swift
//  Homework26CountDownTimer
//
//  Created by 黃柏嘉 on 2021/11/30.
//

import UIKit

class ViewController: UIViewController {
    
    //setView
    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //tilte & timeLabel
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    //View
    @IBOutlet weak var mainView: UIView!
    
    //variable
    var isPlaying = false
    var numberFormatter = NumberFormatter()
    var interval = 0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //因為是倒數計時所以最小能選擇的日子就是當天
        datePicker.minimumDate = Date()
        //設定數字格式兩位數，不到兩位數的補0
        numberFormatter.formatWidth = 2
        numberFormatter.paddingCharacter = "0"
    }
    
    @IBAction func openSetView(_ sender: UIButton) {
        setViewSwitch(isOpen: false)
    }
    //判定是否目前有到數計時進行中，如果有的話先停止原本的再開始新的計時器
    @IBAction func start(_ sender: UIButton) {
        if isPlaying == false{
            interval = Int(datePicker.date.timeIntervalSinceNow)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            setViewSwitch(isOpen: true)
            titleLabel.text = titleTextField.text
            isPlaying = true
        }else{
            timer?.invalidate()
            interval = Int(datePicker.date.timeIntervalSinceNow)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            setViewSwitch(isOpen: true)
            titleLabel.text = titleTextField.text
            isPlaying = false
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        setViewSwitch(isOpen: true)
    }
    //判斷目前開關狀態
    func setViewSwitch(isOpen:Bool){
        if isOpen == false{
            UIView.animate(withDuration: 0.5) {
                self.setView.frame.origin.y -= 560
                self.mainView.alpha = 0.5
                
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.setView.frame.origin.y += 560
                self.mainView.alpha = 1
            }
        }
    }
    //計時器方法
    @objc func countDown(){
        let month = interval/(60*60*24*31)
        let day = interval/(60*60*24)%31
        let hour = interval/(60*60)%24
        let minute = interval/60%60
        let second = interval%60
        monthLabel.text = numberFormatter.string(from: NSNumber(value: month))!+"M"
        dayLabel.text = numberFormatter.string(from: NSNumber(value: day))!+"D"
        hourLabel.text = numberFormatter.string(from: NSNumber(value: hour))!+"h"
        minuteLabel.text = numberFormatter.string(from: NSNumber(value: minute))!+"m"
        secondLabel.text = numberFormatter.string(from: NSNumber(value: second))!+"sec"
        
        if interval>0{
            interval -= 1
        }else{
            timer?.invalidate()
        }
    }
    
   
    
}

