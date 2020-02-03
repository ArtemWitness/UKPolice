//
//  StatVC.swift
//  UK Police
//
//  Created by Artem Trembach on 01.02.2020.
//  Copyright © 2020 Artem Trembach. All rights reserved.
//

import UIKit

class StatVC: UIViewController {
    
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
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descLabelConstBottom: NSLayoutConstraint!
    @IBOutlet weak var crymeType1: UIView!
    @IBOutlet weak var crymeType1Type: UILabel!
    @IBOutlet weak var crymeType1Count: UILabel!
    @IBOutlet weak var crymeType2: UIView!
    @IBOutlet weak var crymeType2Type: UILabel!
    @IBOutlet weak var crymeType2Count: UILabel!
    @IBOutlet weak var crymeType3: UIView!
    @IBOutlet weak var crymeType3Type: UILabel!
    @IBOutlet weak var crymeType3Count: UILabel!
    @IBOutlet weak var crymeType4: UIView!
    @IBOutlet weak var crymeType4Type: UILabel!
    @IBOutlet weak var crymeType4Count: UILabel!
    @IBOutlet weak var crymeType5: UIView!
    @IBOutlet weak var crymeType5Type: UILabel!
    @IBOutlet weak var crymeType5Count: UILabel!
    @IBOutlet weak var crymeType6: UIView!
    @IBOutlet weak var crymeType6Type: UILabel!
    @IBOutlet weak var crymeType6Count: UILabel!
    @IBOutlet weak var crymeType7: UIView!
    @IBOutlet weak var crymeType7Type: UILabel!
    @IBOutlet weak var crymeType7Count: UILabel!
    @IBOutlet weak var crymeType8: UIView!
    @IBOutlet weak var crymeType8Type: UILabel!
    @IBOutlet weak var crymeType8Count: UILabel!
    @IBOutlet weak var crymeType9: UIView!
    @IBOutlet weak var crymeType9Type: UILabel!
    @IBOutlet weak var crymeType9Count: UILabel!
    @IBOutlet weak var crymeType10: UIView!
    @IBOutlet weak var crymeType10Type: UILabel!
    @IBOutlet weak var crymeType10Count: UILabel!
    @IBOutlet weak var crymeType11: UIView!
    @IBOutlet weak var crymeType11Type: UILabel!
    @IBOutlet weak var crymeType11Count: UILabel!
    @IBOutlet weak var crymeType12: UIView!
    @IBOutlet weak var crymeType12Type: UILabel!
    @IBOutlet weak var crymeType12Count: UILabel!
    @IBOutlet weak var crymeType13: UIView!
    @IBOutlet weak var crymeType13Type: UILabel!
    @IBOutlet weak var crymeType13Count: UILabel!
    @IBOutlet weak var crymeType14: UIView!
    @IBOutlet weak var crymeType14Type: UILabel!
    @IBOutlet weak var crymeType14Count: UILabel!
    
    @IBOutlet weak var buttonLogo: UIButton!
    @IBAction func buttonLogoTapped(_ sender: Any) {
        animBackToMainVC()
    }
    
    
    
    // MARK: Initial UI setup
    // ----------------------------------------------------------------------------------------- //
    func uiPrepare() {
        buttonLogo.isHidden = true
        buttonLogo.isEnabled = false
        crymeType1.alpha = 0
        crymeType2.alpha = 0
        crymeType3.alpha = 0
        crymeType4.alpha = 0
        crymeType5.alpha = 0
        crymeType6.alpha = 0
        crymeType7.alpha = 0
        crymeType8.alpha = 0
        crymeType9.alpha = 0
        crymeType10.alpha = 0
        crymeType11.alpha = 0
        crymeType12.alpha = 0
        crymeType13.alpha = 0
        crymeType14.alpha = 0
        crymeType1.addDashBorder()
        crymeType2.addBorder()
        crymeType3.addDashBorder()
        crymeType4.addBorder()
        crymeType5.addDashBorder()
        crymeType6.addBorder()
        crymeType7.addDashBorder()
        crymeType8.addBorder()
        crymeType9.addDashBorder()
        crymeType10.addBorder()
        crymeType11.addDashBorder()
        crymeType12.addBorder()
        crymeType13.addDashBorder()
        crymeType14.addBorder()
        topMenuImg.image = UIImage(named: "iconLogo")
        mainBG.backgroundColor = hexStringToUIColor(hex: uiColors.DarkBlue)
        splitView.backgroundColor = hexStringToUIColor(hex: uiColors.Light)
        splitView.alpha = 0
        splitViewConstBottom.constant = -22
        descLabel.alpha = 0
        descLabelConstBottom.constant = 40
        setupLabel(label: topMenuLabel, size: "normal", color: uiColors.Light)
        setupLabel(label: descLabel, size: "small", color: uiColors.Light)
        setupLabel(label: crymeType1Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType2Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType3Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType4Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType5Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType6Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType7Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType8Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType9Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType10Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType11Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType12Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType13Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType14Type, size: "tiny", color: uiColors.Light)
        setupLabel(label: crymeType1Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType2Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType3Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType4Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType5Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType6Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType7Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType8Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType9Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType10Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType11Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType12Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType13Count, size: "huge", color: uiColors.Light)
        setupLabel(label: crymeType14Count, size: "huge", color: uiColors.Light)
        let sumCrimes : Int = localData.crimeCountAntiSocialBehaviour + localData.crimeCountBicycleTheft + localData.crimeCountBurglary + localData.crimeCountCriminalDamageArson + localData.crimeCountDrugs + localData.crimeCountOtherTheft + localData.crimeCountPossessionOfWeapons + localData.crimeCountPublicOrder + localData.crimeCountRobbery + localData.crimeCountShoplifting + localData.crimeCountTheftFromThePerson + localData.crimeCountVehicleCrime + localData.crimeCountViolentCrime + localData.crimeCountOtherCrime
        crymeType1Count.text = String(localData.crimeCountAntiSocialBehaviour)
        crymeType2Count.text = String(localData.crimeCountBicycleTheft)
        crymeType3Count.text = String(localData.crimeCountBurglary)
        crymeType4Count.text = String(localData.crimeCountCriminalDamageArson)
        crymeType5Count.text = String(localData.crimeCountDrugs)
        crymeType6Count.text = String(localData.crimeCountOtherTheft)
        crymeType7Count.text = String(localData.crimeCountPossessionOfWeapons)
        crymeType8Count.text = String(localData.crimeCountPublicOrder)
        crymeType9Count.text = String(localData.crimeCountRobbery)
        crymeType10Count.text = String(localData.crimeCountShoplifting)
        crymeType11Count.text = String(localData.crimeCountTheftFromThePerson)
        crymeType12Count.text = String(localData.crimeCountVehicleCrime)
        crymeType13Count.text = String(localData.crimeCountViolentCrime)
        crymeType14Count.text = String(localData.crimeCountOtherCrime)
        topMenuLabel.text = "Crime stat"
        crymeType1Type.text = "Anti-social behaviour"
        crymeType2Type.text = "Bicycle theft"
        crymeType3Type.text = "Burglary"
        crymeType4Type.text = "Criminal damage and arson"
        crymeType5Type.text = "Drugs"
        crymeType6Type.text = "Other theft"
        crymeType7Type.text = "Possession of weapons"
        crymeType8Type.text = "Public order"
        crymeType9Type.text = "Robbery"
        crymeType10Type.text = "Shoplifting"
        crymeType11Type.text = "Theft from the person"
        crymeType12Type.text = "Vehicle crime"
        crymeType13Type.text = "Violence and sexual offences"
        crymeType14Type.text = "Other crime"
        descLabel.text = "Over the past month, \(sumCrimes) crimes were committed in the United Kingdom. All criminals are caught and punished to the fullest extent of the law, sir."
        
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
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.15, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.descLabel.alpha = 1
            self.descLabelConstBottom.constant = 20
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.25, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType1.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.35, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType8.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.45, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType9.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.55, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType2.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.65, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType3.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.75, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType10.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.85, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType11.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 0.95, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType4.alpha = 1
        }, completion: {finished in
            self.buttonLogo.isHidden = false
            self.buttonLogo.isEnabled = true
        })
        UIView.animate(withDuration: 0.75, delay: 1.05, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType5.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.15, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType12.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.25, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType13.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.35, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType6.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.45, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType7.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.75, delay: 1.55, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.crymeType14.alpha = 1
        }, completion: nil)
    }
    
    
    
    // MARK: Dismiss this VC
    // ----------------------------------------------------------------------------------------- //
    func animBackToMainVC() {
        buttonLogo.isHidden = true
        buttonLogo.isEnabled = false
        mainVCAnimController = "backFromStatVC"
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: allAnimDamp, initialSpringVelocity: allAnimvel, options: .curveEaseOut, animations: {
            self.splitView.alpha = 0
            self.descLabel.alpha = 0
            self.crymeType1.alpha = 0
            self.crymeType2.alpha = 0
            self.crymeType3.alpha = 0
            self.crymeType4.alpha = 0
            self.crymeType5.alpha = 0
            self.crymeType6.alpha = 0
            self.crymeType7.alpha = 0
            self.crymeType8.alpha = 0
            self.crymeType9.alpha = 0
            self.crymeType10.alpha = 0
            self.crymeType11.alpha = 0
            self.crymeType12.alpha = 0
            self.crymeType13.alpha = 0
            self.crymeType14.alpha = 0
        }, completion: {finished in
            self.dismiss(animated: false, completion: nil)
        })
    }










}
