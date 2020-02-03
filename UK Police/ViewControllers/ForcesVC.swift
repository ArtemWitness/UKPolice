//
//  ForcesVC.swift
//  UK Police
//
//  Created by Artem Trembach on 01.02.2020.
//  Copyright © 2020 Artem Trembach. All rights reserved.
//

import UIKit
import SDWebImage

class ForcesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiPrepare()
    }
    
    
    
    // MARK: Links & Connects
    // ----------------------------------------------------------------------------------------- //
    @IBOutlet var mainBG: UIView!
    @IBOutlet weak var topMenuImg: UIImageView!
    @IBOutlet weak var topMenuLabel: UILabel!
    @IBOutlet weak var splitView: UIView!
    @IBOutlet weak var splitViewConstBottom: NSLayoutConstraint!
    @IBOutlet weak var tableViewForces: UITableView!
    @IBOutlet weak var specificForceNameLable: UILabel!
    @IBOutlet weak var specificForceNameLableConstBottom: NSLayoutConstraint!
    @IBOutlet weak var splitView2: UIView!
    @IBOutlet weak var splitViewConstBottom2: NSLayoutConstraint!
    @IBOutlet weak var contactsView: UIView!
    @IBOutlet weak var forceDesc: UILabel!
    @IBOutlet weak var iconWeb: UIImageView!
    @IBOutlet weak var iconPhone: UIImageView!
    @IBOutlet weak var iconFB: UIImageView!
    @IBOutlet weak var iconTwitter: UIImageView!
    @IBOutlet weak var iconYT: UIImageView!
    let cellID = "cellID"
    
    @IBOutlet weak var buttonLogo: UIButton!
    @IBAction func buttonLogoTapped(_ sender: Any) {
        animBackToMainVC()
    }
    
    @IBOutlet weak var buttonWeb: UIButton!
    @IBAction func buttonWebTapped(_ sender: Any) {
        openWeb(url: localData.aForcesIDsURL[specificForce])
    }
    
    @IBOutlet weak var buttonPhone: UIButton!
    @IBAction func buttonPhoneTapped(_ sender: Any) {
        phoneCall(number: localData.aForcesIDsTelephone[specificForce])
    }
    
    @IBOutlet weak var buttonFB: UIButton!
    @IBAction func buttonFBTapped(_ sender: Any) {
        openWeb(url: localData.aForcesIDsFacebook[specificForce])
    }
    
    @IBOutlet weak var buttonTwitter: UIButton!
    @IBAction func buttonTwitterTapped(_ sender: Any) {
        openWeb(url: localData.aForcesIDsTwitter[specificForce])
    }
    
    @IBOutlet weak var buttonYT: UIButton!
    @IBAction func buttonYTTapped(_ sender: Any) {
        openWeb(url: localData.aForcesIDsYoutube[specificForce])
    }
    
    
    
    // MARK: Initial UI setup
    // ----------------------------------------------------------------------------------------- //
    func uiPrepare() {
        buttonLogo.isHidden = true
        buttonLogo.isEnabled = false
        buttonWeb.isHidden = true
        buttonWeb.isEnabled = false
        buttonPhone.isHidden = true
        buttonPhone.isEnabled = false
        buttonFB.isHidden = true
        buttonFB.isEnabled = false
        buttonTwitter.isHidden = true
        buttonTwitter.isEnabled = false
        buttonYT.isHidden = true
        buttonYT.isEnabled = false
        tableViewForces.backgroundColor = .clear
        mainBG.backgroundColor = hexStringToUIColor(hex: uiColors.DarkBlue)
        splitView.backgroundColor = hexStringToUIColor(hex: uiColors.Light)
        splitView.alpha = 0
        splitView2.backgroundColor = hexStringToUIColor(hex: uiColors.Light)
        splitView2.alpha = 0
        contactsView.alpha = 0
        tableViewForces.alpha = 0
        tableViewForces.dataSource = self
        tableViewForces.delegate = self
        tableViewForces.register(UINib(nibName: "forcesCell", bundle: nil), forCellReuseIdentifier: cellID)
        iconWeb.image = UIImage(named: "iconContactWeb")
        iconPhone.image = UIImage(named: "iconContactPhone")
        iconFB.image = UIImage(named: "iconContactFb")
        iconTwitter.image = UIImage(named: "iconContactTwitter")
        iconYT.image = UIImage(named: "iconContactYouTube")
        topMenuImg.image = UIImage(named: "iconLogo")
        forceDesc.alpha = 0
        specificForceNameLable.alpha = 0
        setupLabel(label: forceDesc, size: "tiny", color: uiColors.Light)
        setupLabel(label: topMenuLabel, size: "normal", color: uiColors.Light)
        setupLabel(label: specificForceNameLable, size: "small", color: uiColors.Light)
        topMenuLabel.text = "Police forces"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.animIntro()
        }
    }
    
    
    
    // MARK: Intro animation
    // ----------------------------------------------------------------------------------------- //
    func animIntro() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.splitView.alpha = 1
            self.splitViewConstBottom.constant = -2
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.buttonLogo.isHidden = false
            self.buttonLogo.isEnabled = true
            self.animateTable()
        })
    }
    
    
    
    // MARK: Dismiss this VC
    // ----------------------------------------------------------------------------------------- //
    func animBackToMainVC() {
        buttonLogo.isHidden = true
        buttonLogo.isEnabled = false
        buttonWeb.isHidden = true
        buttonWeb.isEnabled = false
        buttonPhone.isHidden = true
        buttonPhone.isEnabled = false
        buttonFB.isHidden = true
        buttonFB.isEnabled = false
        buttonTwitter.isHidden = true
        buttonTwitter.isEnabled = false
        buttonYT.isHidden = true
        buttonYT.isEnabled = false
        mainVCAnimController = "backFromForcesVC"
        UIView.animate(withDuration: 0.375, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.specificForceNameLable.alpha = 0
        }, completion: {finished in
            UIView.animate(withDuration: 0.375, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
                self.topMenuLabel.alpha = 1
            }, completion: nil)
        })
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.splitView.alpha = 0
            self.splitView2.alpha = 0
            self.tableViewForces.alpha = 0
            self.forceDesc.alpha = 0
            self.contactsView.alpha = 0
        }, completion: {finished in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    
    
    // MARK: Setup tableViewForces
    // ----------------------------------------------------------------------------------------- //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.aForcesIDs.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewForces.dequeueReusableCell(withIdentifier: cellID) as! forcesCell
        cell.selectionStyle = .none
        setupLabel(label: cell.forceName, size: "small", color: uiColors.Light)
        cell.forceName.text = localData.aForcesIDsNames[indexPath.row]
        let imageURL = URL(string: localData.aForcesIDsLogoSimulate[indexPath.row])!
        let placeholderImage = UIImage(named: "iconForceLogo")
        cell.forceLogo .sd_setImage(with: imageURL, placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority, context: nil, progress: nil) { img, err, cacheType, url in
            if let err = err { print(err) }
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewForces.deselectRow(at: indexPath, animated: true)
        specificForce = indexPath.row
        changeViewToSpecific()
    }
    
    
    
    // Animated open tableView
    // ----------------------------------------------------------------------------------------- //
    func animateTable() {
        tableViewForces.reloadData()
        tableViewForces.alpha = 1
        let cells = tableViewForces.visibleCells
        
        let tableViewHeight = tableViewForces.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                }, completion: nil)
            delayCounter += 1
        }
        
    }
    
    
    
    // MARK: Show current force data
    // ----------------------------------------------------------------------------------------- //
    var specificForce : Int = 0
    func changeViewToSpecific() {
        buttonLogo.isHidden = true
        buttonLogo.isEnabled = false
        specificForceNameLable.text = localData.aForcesIDsNames[specificForce]
        forceDesc.text = localData.aForcesIDsDescription[specificForce]
        if localData.aForcesIDsURL[specificForce] == "nil" {
            iconWeb.alpha = 0.5
            buttonWeb.isHidden = true
            buttonWeb.isEnabled = false
        } else if localData.aForcesIDsURL[specificForce] != "nil" {
            iconWeb.alpha = 1
            buttonWeb.isHidden = false
            buttonWeb.isEnabled = true
        }
        if localData.aForcesIDsTelephone[specificForce] == "nil" {
            iconPhone.alpha = 0.5
            buttonPhone.isHidden = true
            buttonPhone.isEnabled = false
        } else if localData.aForcesIDsTelephone[specificForce] != "nil" {
            iconPhone.alpha = 1
            buttonPhone.isHidden = false
            buttonPhone.isEnabled = true
        }
        if localData.aForcesIDsFacebook[specificForce] == "nil" {
            iconFB.alpha = 0.5
            buttonFB.isHidden = true
            buttonFB.isEnabled = false
        } else if localData.aForcesIDsFacebook[specificForce] != "nil" {
            iconFB.alpha = 1
            buttonFB.isHidden = false
            buttonFB.isEnabled = true
        }
        if localData.aForcesIDsTwitter[specificForce] == "nil" {
            iconTwitter.alpha = 0.5
            buttonTwitter.isHidden = true
            buttonTwitter.isEnabled = false
        } else if localData.aForcesIDsTwitter[specificForce] != "nil" {
            iconTwitter.alpha = 1
            buttonTwitter.isHidden = false
            buttonTwitter.isEnabled = true
        }
        if localData.aForcesIDsYoutube[specificForce] == "nil" {
            iconYT.alpha = 0.5
            buttonYT.isHidden = true
            buttonYT.isEnabled = false
        } else if localData.aForcesIDsYoutube[specificForce] != "nil" {
            iconYT.alpha = 1
            buttonYT.isHidden = false
            buttonYT.isEnabled = true
        }
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.topMenuLabel.alpha = 0
            self.tableViewForces.alpha = 0
        }, completion: {finished in
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
                self.specificForceNameLable.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
                self.forceDesc.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 0.75, delay: 0.3, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
                self.splitView2.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: 0.75, delay: 0.45, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
                self.contactsView.alpha = 1
            }, completion: {finished in
                self.buttonLogo.isHidden = false
                self.buttonLogo.isEnabled = true
            })
        })
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
    
    
    
    // Open web page
    // ----------------------------------------------------------------------------------------- //
    func openWeb(url : String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    





}
