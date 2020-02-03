//
//  MainVC.swift
//  UK Police
//
//  Created by Artem Trembach on 01.02.2020.
//  Copyright © 2020 Artem Trembach. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiPrepare()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if mainVCAnimController == "begin" {
            waitTillFetch()
        } else if mainVCAnimController == "backFromStatVC" {
            animBackFromStatVC()
        } else if mainVCAnimController == "backFromForcesVC" {
            animBackFromForcesVC()
        } else {
            
        }
    }
    
    
    
    // MARK: Links & Connects
    // ----------------------------------------------------------------------------------------- //
    @IBOutlet var mainBG: UIView!
    @IBOutlet weak var topMenuImg: UIImageView!
    @IBOutlet weak var topMenuImgWidth: NSLayoutConstraint!
    @IBOutlet weak var topMenuImgConstX: NSLayoutConstraint!
    @IBOutlet weak var topMenuImgConstY: NSLayoutConstraint!
    @IBOutlet weak var topMenuLabel: UILabel!
    @IBOutlet weak var topMenuLabelConstTop: NSLayoutConstraint!
    @IBOutlet weak var bottomMenu1Label: UILabel!
    @IBOutlet weak var bottomMenu1ConstTop: NSLayoutConstraint!
    @IBOutlet weak var bottomMenu2Label: UILabel!
    @IBOutlet weak var bottomMenu2ConstTop: NSLayoutConstraint!
    @IBOutlet weak var bottomMenu3Label: UILabel!
    @IBOutlet weak var bottomMenu3ConstTop: NSLayoutConstraint!
    @IBOutlet weak var loadBar: UIView!
    @IBOutlet weak var loadBarConstRight: NSLayoutConstraint!
    
    @IBOutlet weak var buttonMenu1: UIButton!
    @IBAction func buttonMenu1Tapped(_ sender: Any) {
        animGoToStatVC()
    }
    
    @IBOutlet weak var buttonMenu2: UIButton!
    @IBAction func buttonMenu2Tapped(_ sender: Any) {
        animGoToForcesVC()
    }
    
    @IBOutlet weak var buttonMenu3: UIButton!
    @IBAction func buttonMenu3Tapped(_ sender: Any) {
        phoneCall(number: "999")
    }
    
    
    
    
    // MARK: Initial UI setup
    // ----------------------------------------------------------------------------------------- //
    func uiPrepare() {
        allButtons(turn: "off")
        topMenuImg.image = UIImage(named: "iconLogo")
        mainBG.backgroundColor = hexStringToUIColor(hex: uiColors.DarkBlue)
        loadBar.backgroundColor = hexStringToUIColor(hex: uiColors.LightBlue)
        loadBar.alpha = 0
        topMenuImgWidth.constant = 70
        topMenuImgConstX.constant = 0
        topMenuImgConstY.constant = 0
        topMenuLabel.text = "UK Police"
        setupLabel(label: topMenuLabel, size: "normal", color: uiColors.Light)
        topMenuLabel.alpha = 0
        topMenuLabelConstTop.constant = 0
        bottomMenu1Label.text = "Crime stat"
        setupLabel(label: bottomMenu1Label, size: "normal", color: uiColors.LightBlue)
        bottomMenu1Label.alpha = 0
        bottomMenu1ConstTop.constant = 129 + 20
        bottomMenu2Label.text = "Police forces"
        setupLabel(label: bottomMenu2Label, size: "normal", color: uiColors.LightBlue)
        bottomMenu2Label.alpha = 0
        bottomMenu2ConstTop.constant = 74.5 + 20
        bottomMenu3Label.text = "Emergency call"
        setupLabel(label: bottomMenu3Label, size: "normal", color: uiColors.LightBlue)
        bottomMenu3Label.alpha = 0
        bottomMenu3ConstTop.constant = 20 + 20
    }
    
    
    
    // MARK: Intro animation
    // ----------------------------------------------------------------------------------------- //
    func animIntro() {
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.topMenuImgWidth.constant = 30
            let newImgConstX = self.view.safeAreaLayoutGuide.layoutFrame.size.width / 2 - 35
            let newImgConstY =  0 - self.view.safeAreaLayoutGuide.layoutFrame.size.height / 2 + 38
            self.topMenuImgConstX.constant = newImgConstX
            self.topMenuImgConstY.constant = newImgConstY
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.loadBar.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.75, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.topMenuLabel.alpha = 1
            self.topMenuLabelConstTop.constant = 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.9, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.bottomMenu1Label.alpha = 1
            self.bottomMenu1ConstTop.constant = 129
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.05, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.bottomMenu2Label.alpha = 1
            self.bottomMenu2ConstTop.constant = 74.5
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.2, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.bottomMenu3Label.alpha = 1
            self.bottomMenu3ConstTop.constant = 20
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.allButtons(turn: "on")
            mainVCAnimController = ""
        })
    }
    
    
    
    // MARK: Animation - go to StatVC
    // ----------------------------------------------------------------------------------------- //
    func animGoToStatVC() {
        allButtons(turn: "off")
        UIView.animate(withDuration: 0.75, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.topMenuLabel.alpha = 0
            self.topMenuLabelConstTop.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
            self.bottomMenu2Label.alpha = 0
            self.bottomMenu2ConstTop.constant += 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.15, delay: 0.3, animations: {
            self.bottomMenu3Label.alpha = 0
            self.bottomMenu3ConstTop.constant += 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            setupLabel(label: self.bottomMenu1Label, size: "normal", color: uiColors.Light)
            self.bottomMenu1ConstTop.constant = self.view.safeAreaLayoutGuide.layoutFrame.size.height - 54.5
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.performSegue(withIdentifier: "segueGoToStatVC", sender: self)
            mainVCAnimController = ""
        })

    }
    
    
    
    // Animation - back from StatVC
    // ----------------------------------------------------------------------------------------- //
    func animBackFromStatVC() {
        UIView.animate(withDuration: 0.75, delay: 0.5, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.topMenuLabel.alpha = 1
            self.topMenuLabelConstTop.constant = 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            setupLabel(label: self.bottomMenu1Label, size: "normal", color: uiColors.LightBlue)
            self.bottomMenu1ConstTop.constant = 129
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.allButtons(turn: "on")
            mainVCAnimController = ""
        })
        UIView.animate(withDuration: 0.75, delay: 0.5, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.bottomMenu2Label.alpha = 1
            self.bottomMenu2ConstTop.constant -= 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.65, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.bottomMenu3Label.alpha = 1
            self.bottomMenu3ConstTop.constant -= 20
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    
    // MARK: Animation - go to ForcesVC
    // ----------------------------------------------------------------------------------------- //
    func animGoToForcesVC() {
        allButtons(turn: "off")
        UIView.animate(withDuration: 0.75, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.topMenuLabel.alpha = 0
            self.topMenuLabelConstTop.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.15, delay: 0.0, animations: {
            self.bottomMenu1Label.alpha = 0
            self.bottomMenu1ConstTop.constant += 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.25, delay: 0.0, animations: {
            self.bottomMenu3Label.alpha = 0
            self.bottomMenu3ConstTop.constant += 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            setupLabel(label: self.bottomMenu2Label, size: "normal", color: uiColors.Light)
            self.bottomMenu2ConstTop.constant = self.view.safeAreaLayoutGuide.layoutFrame.size.height - 54.5
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.performSegue(withIdentifier: "segueGoToForcesVC", sender: self)
            mainVCAnimController = ""
        })
    }
    
    
    
    // Animation - back from ForcesVC
    // ----------------------------------------------------------------------------------------- //
    func animBackFromForcesVC() {
        UIView.animate(withDuration: 0.75, delay: 0.5, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.topMenuLabel.alpha = 1
            self.topMenuLabelConstTop.constant = 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            setupLabel(label: self.bottomMenu2Label, size: "normal", color: uiColors.LightBlue)
            self.bottomMenu2ConstTop.constant = 74.5
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.allButtons(turn: "on")
            mainVCAnimController = ""
        })
        UIView.animate(withDuration: 0.75, delay: 0.5, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.bottomMenu1Label.alpha = 1
            self.bottomMenu1ConstTop.constant -= 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.65, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseInOut, animations: {
            self.bottomMenu3Label.alpha = 1
            self.bottomMenu3ConstTop.constant -= 20
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    
    // Phone call
    // ----------------------------------------------------------------------------------------- //
    func phoneCall(number : String) {
        if let phoneCallURL = URL(string: "telprompt://\(number)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    
    // All buttons status
    // ----------------------------------------------------------------------------------------- //
    func allButtons(turn : String) {
        if turn == "on" {
            buttonMenu1.isHidden = false
            buttonMenu1.isEnabled = true
            buttonMenu2.isHidden = false
            buttonMenu2.isEnabled = true
            buttonMenu3.isHidden = false
            buttonMenu3.isEnabled = true
        } else if turn == "off" {
            buttonMenu1.isHidden = true
            buttonMenu1.isEnabled = false
            buttonMenu2.isHidden = true
            buttonMenu2.isEnabled = false
            buttonMenu3.isHidden = true
            buttonMenu3.isEnabled = false
            
        }
    }
    
    
    
    // Load bar
    // ----------------------------------------------------------------------------------------- //
    func waitTillFetch() {
        if appGo == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.waitTillFetch() }
            loadBar.alpha = 1
            let onePercWidth = UIScreen.main.bounds.width / 100
            loadBarConstRight.constant = CGFloat((100 - appGoLoadBar)) * onePercWidth
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { self.animIntro() }
        }
    }


}
