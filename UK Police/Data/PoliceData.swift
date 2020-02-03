//
//  PoliceData.swift
//  UK Police
//
//  Created by Artem Trembach on 01.02.2020.
//  Copyright © 2020 Artem Trembach. All rights reserved.
//

import Foundation



// Variables for LoadBar in MainVC
var appGo : Bool = false
var appGoLoadBar : Int = 18



// UK Police API have 15 requests per second limit
// BUT it lose data on this "speed"
// App doesn't lose data only on 5 requests per second
let serverRequestCooldown : Double = 0.2



// Data which saves in local memory by UserDefaults
struct localData {
    static var currentDate : String = ""
    static var crimeCountAntiSocialBehaviour : Int = 0
    static var crimeCountBicycleTheft : Int = 0
    static var crimeCountBurglary : Int = 0
    static var crimeCountCriminalDamageArson : Int = 0
    static var crimeCountDrugs : Int = 0
    static var crimeCountOtherTheft : Int = 0
    static var crimeCountPossessionOfWeapons : Int = 0
    static var crimeCountPublicOrder : Int = 0
    static var crimeCountRobbery : Int = 0
    static var crimeCountShoplifting : Int = 0
    static var crimeCountTheftFromThePerson : Int = 0
    static var crimeCountVehicleCrime : Int = 0
    static var crimeCountViolentCrime : Int = 0
    static var crimeCountOtherCrime : Int = 0
    static var forcesIDs : Array =  [String]()
    static var aForcesIDs : Array =  [String]()
    static var aForcesIDsNames : Array =  [String]()
    static var aForcesIDsLogoSimulate : Array =  [String]()
    static var aForcesIDsDescription : Array =  [String]()
    static var aForcesIDsTelephone : Array =  [String]()
    static var aForcesIDsURL : Array =  [String]()
    static var aForcesIDsFacebook : Array =  [String]()
    static var aForcesIDsTwitter : Array =  [String]()
    static var aForcesIDsYoutube : Array =  [String]()
}



// Structs for JSON
struct criminalDateCheck : Decodable {
    let date : String
}

struct criminalData : Decodable {
    let category : String?
    let persistent_id : String?
}

struct forcesData : Decodable {
    let id : String?
    let name : String?
}

struct forcesSpecificData : Decodable {
    let description : String?
    let url : String?
    let engagement_methods : [forcesContactData]
    let telephone : String?
    let id : String?
    let name : String?
}

struct forcesContactData : Decodable {
    let url : String?
    let type : String?
    let description : String?
    let title : String?
}



// Check if there is already saved crime data
// --------------------------------------------------------------------------------------------- //
func startFetchData() {
    
    let cdcUrl = "https://data.police.uk/api/crime-last-updated"
    guard let url = URL(string: cdcUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        guard let data = data else { return }
        do {
            let date = try JSONDecoder().decode(criminalDateCheck.self, from: data)
            let dateSeparate = date.date.components(separatedBy: "-")
            let currentDate = "\(dateSeparate[0])-\(dateSeparate[1])"
            let oldDate = UserDefaults.standard.string(forKey: "localData.currentDate")
            if currentDate == oldDate {
                // Dates are the same, we use old data on the number of crimes
                print("\n***\nCrime data is available on the device")
                appGoLoadBar += 45
                // Fetch local data
                localData.currentDate = currentDate
                localData.crimeCountAntiSocialBehaviour = UserDefaults.standard.integer(forKey: "localData.crimeCountAntiSocialBehaviour")
                localData.crimeCountBicycleTheft = UserDefaults.standard.integer(forKey: "localData.crimeCountBicycleTheft")
                localData.crimeCountBurglary = UserDefaults.standard.integer(forKey: "localData.crimeCountBurglary")
                localData.crimeCountCriminalDamageArson = UserDefaults.standard.integer(forKey: "localData.crimeCountCriminalDamageArson")
                localData.crimeCountDrugs = UserDefaults.standard.integer(forKey: "localData.crimeCountDrugs")
                localData.crimeCountOtherTheft = UserDefaults.standard.integer(forKey: "localData.crimeCountOtherTheft")
                localData.crimeCountPossessionOfWeapons = UserDefaults.standard.integer(forKey: "localData.crimeCountPossessionOfWeapons")
                localData.crimeCountPublicOrder = UserDefaults.standard.integer(forKey: "localData.crimeCountPublicOrder")
                localData.crimeCountRobbery = UserDefaults.standard.integer(forKey: "localData.crimeCountRobbery")
                localData.crimeCountShoplifting = UserDefaults.standard.integer(forKey: "localData.crimeCountShoplifting")
                localData.crimeCountTheftFromThePerson = UserDefaults.standard.integer(forKey: "localData.crimeCountTheftFromThePerson")
                localData.crimeCountVehicleCrime = UserDefaults.standard.integer(forKey: "localData.crimeCountVehicleCrime")
                localData.crimeCountViolentCrime = UserDefaults.standard.integer(forKey: "localData.crimeCountViolentCrime")
                localData.crimeCountOtherCrime = UserDefaults.standard.integer(forKey: "localData.crimeCountOtherCrime")
                DispatchQueue.main.asyncAfter(deadline: .now() + serverRequestCooldown) { fetchForces() }
            } else {
                // Dates do not match, we create new data on the number of crimes
                print("\n***\nCrime data is not available on the device")
                localData.currentDate = currentDate
                DispatchQueue.main.asyncAfter(deadline: .now() + serverRequestCooldown) { fetchCrimeStat() }
            }
        } catch let jsonError {
            print("\n***\nError - startFetchData()\n", jsonError)
        }
    }.resume()
}



// MARK: Fetch crime data
// --------------------------------------------------------------------------------------------- //
func fetchCrimeStat() {
    print("\n***\nStart fetch crime data")
    let cdcUrl = "https://data.police.uk/api/forces"
    guard let url = URL(string: cdcUrl) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        guard let data = data else { return }
        do {
            let forces = try JSONDecoder().decode([forcesData].self, from: data)
            for force in forces {
                localData.forcesIDs.append(force.id ?? "emptyID")
            }
            fetchCrimeStatCurrentForce(force: localData.forcesIDs.count)
        } catch let jsonError {
            print("\n***\nError - fetchCrimeStat()\n", jsonError)
        }
    }.resume()
}



// Fetch current police force crime data
// --------------------------------------------------------------------------------------------- //
func fetchCrimeStatCurrentForce(force: Int) {
    let requestDelay = Double(force) * serverRequestCooldown
    let newForce = force - 1
    if newForce < 0 {
    } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + requestDelay) {
            let cdcUrl = "https://data.police.uk/api/crimes-no-location?category=all-crime&force=\(localData.forcesIDs[newForce])&date=\(localData.currentDate)"
            guard let url = URL(string: cdcUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    appGoLoadBar += 1
                    let crimes = try JSONDecoder().decode([criminalData].self, from: data)
                    for crime in crimes {
                        if crime.category == "anti-social-behaviour" {
                            localData.crimeCountAntiSocialBehaviour += 1
                        } else if crime.category == "bicycle-theft" {
                            localData.crimeCountBicycleTheft += 1
                        } else if crime.category == "burglary" {
                            localData.crimeCountBurglary += 1
                        } else if crime.category == "criminal-damage-arson" {
                            localData.crimeCountCriminalDamageArson += 1
                        } else if crime.category == "drugs" {
                            localData.crimeCountDrugs += 1
                        } else if crime.category == "other-theft" {
                            localData.crimeCountOtherTheft += 1
                        } else if crime.category == "possession-of-weapons" {
                            localData.crimeCountPossessionOfWeapons += 1
                        } else if crime.category == "public-order" {
                            localData.crimeCountPublicOrder += 1
                        } else if crime.category == "robbery" {
                            localData.crimeCountRobbery += 1
                        } else if crime.category == "shoplifting" {
                            localData.crimeCountShoplifting += 1
                        } else if crime.category == "theft-from-the-person" {
                            localData.crimeCountTheftFromThePerson += 1
                        } else if crime.category == "vehicle-crime" {
                            localData.crimeCountVehicleCrime += 1
                        } else if crime.category == "violent-crime" {
                            localData.crimeCountViolentCrime += 1
                        } else if crime.category == "other-crime" {
                            localData.crimeCountOtherCrime += 1
                        }
                    }
                    if localData.forcesIDs[newForce] == localData.forcesIDs.last {
                        print("\n***\nFinish fetch crime data")
                        fetchForces()
                        saveCrimesData()
                    }
                } catch let jsonError {
                    appGoLoadBar += 1
                    print("\n***\nError - fetchCrimeStatCurrentForce(\(localData.forcesIDs[newForce]))\n", jsonError)
                    if localData.forcesIDs[newForce] == localData.forcesIDs.last {
                        print("\n***\nFinish fetch crime data")
                        fetchForces()
                        saveCrimesData()
                    }
                }
            }.resume()
        }
        fetchCrimeStatCurrentForce(force: newForce)
    }
}



// Save crime data locally
// --------------------------------------------------------------------------------------------- //
func saveCrimesData() {
    UserDefaults.standard.set(localData.currentDate, forKey: "localData.currentDate")
    UserDefaults.standard.set(localData.crimeCountAntiSocialBehaviour, forKey: "localData.crimeCountAntiSocialBehaviour")
    UserDefaults.standard.set(localData.crimeCountBicycleTheft, forKey: "localData.crimeCountBicycleTheft")
    UserDefaults.standard.set(localData.crimeCountBurglary, forKey: "localData.crimeCountBurglary")
    UserDefaults.standard.set(localData.crimeCountCriminalDamageArson, forKey: "localData.crimeCountCriminalDamageArson")
    UserDefaults.standard.set(localData.crimeCountDrugs, forKey: "localData.crimeCountDrugs")
    UserDefaults.standard.set(localData.crimeCountOtherTheft, forKey: "localData.crimeCountOtherTheft")
    UserDefaults.standard.set(localData.crimeCountPossessionOfWeapons, forKey: "localData.crimeCountPossessionOfWeapons")
    UserDefaults.standard.set(localData.crimeCountPublicOrder, forKey: "localData.crimeCountPublicOrder")
    UserDefaults.standard.set(localData.crimeCountRobbery, forKey: "localData.crimeCountRobbery")
    UserDefaults.standard.set(localData.crimeCountShoplifting, forKey: "localData.crimeCountShoplifting")
    UserDefaults.standard.set(localData.crimeCountTheftFromThePerson, forKey: "localData.crimeCountTheftFromThePerson")
    UserDefaults.standard.set(localData.crimeCountVehicleCrime, forKey: "localData.crimeCountVehicleCrime")
    UserDefaults.standard.set(localData.crimeCountViolentCrime, forKey: "localData.crimeCountViolentCrime")
    UserDefaults.standard.set(localData.crimeCountOtherCrime, forKey: "localData.crimeCountOtherCrime")
}



// MARK: Fetch forces data
// --------------------------------------------------------------------------------------------- //
func fetchForces() {
    print("\n***\nStart fetch police forces data")
    if localData.forcesIDs == [] {
        let cdcUrl = "https://data.police.uk/api/forces"
        guard let url = URL(string: cdcUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let forces = try JSONDecoder().decode([forcesData].self, from: data)
                for force in forces {
                    localData.forcesIDs.append(force.id ?? "emptyID")
                }
                fetchForcesSpecific(force: localData.forcesIDs.count)
            } catch let jsonError {
                print("\n***\nError - fetchForces()\n", jsonError)
            }
        }.resume()
    } else {
        fetchForcesSpecific(force: localData.forcesIDs.count)
    }
}



// Fetch current police forces data
// --------------------------------------------------------------------------------------------- //
func fetchForcesSpecific(force: Int) {
    let requestDelay = Double(force) * serverRequestCooldown
    let newForce = force - 1
    if newForce < 0 {
    } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + requestDelay) {
            let cdcUrl = "https://data.police.uk/api/forces/\(localData.forcesIDs[newForce])"
            guard let url = URL(string: cdcUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    appGoLoadBar += 1
                    let forcesInfo = try JSONDecoder().decode(forcesSpecificData.self, from: data)
                    let dirtyDesc = forcesInfo.description ?? "\(forcesInfo.name ?? "Current force") was created to prevent crime and protect the public."
                    let clearDesc = dirtyDesc.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    let imgUrl = simulateImgUrlInJSON(id: forcesInfo.id!)
                    var secretFB : String = ""
                    var secretTwitter : String = ""
                    var secretYouTube : String = ""
                    for contact in forcesInfo.engagement_methods {
                        if contact.title == "Facebook" {
                            secretFB = contact.url ?? "nil"
                        } else if contact.title != "Facebook" {
                            if secretFB == "" {
                                secretFB = "nil"
                            }
                        }
                        if contact.title == "Twitter" {
                            secretTwitter = contact.url ?? "nil"
                        } else if contact.title != "Twitter" {
                            if secretTwitter == "" {
                                secretTwitter = "nil"
                            }
                        }
                        if contact.title == "YouTube" {
                            secretYouTube = contact.url ?? "nil"
                        } else if contact.title != "YouTube" {
                            if secretYouTube == "" {
                                secretYouTube = "nil"
                            }
                        }
                    }
                    localData.aForcesIDs.append(forcesInfo.id ?? "nil")
                    localData.aForcesIDsNames.append(forcesInfo.name ?? "nil")
                    localData.aForcesIDsDescription.append(clearDesc)
                    localData.aForcesIDsTelephone.append(forcesInfo.telephone ?? "nil")
                    localData.aForcesIDsURL.append(forcesInfo.url ?? "nil")
                    localData.aForcesIDsLogoSimulate.append(imgUrl)
                    localData.aForcesIDsFacebook.append(secretFB)
                    localData.aForcesIDsTwitter.append(secretTwitter)
                    localData.aForcesIDsYoutube.append(secretYouTube)
                    if localData.forcesIDs[newForce] == localData.forcesIDs.last {
                        print("\n***\nFinish fetch police forces data")
                        appGo = true
                    }
                } catch let jsonError {
                    appGoLoadBar += 1
                    print("\n***\nError - fetchForcesSpecific(\(localData.forcesIDs[newForce]))\n", jsonError)
                    if localData.forcesIDs[newForce] == localData.forcesIDs.last {
                        print("\n***\nFinish fetch police forces data")
                        appGo = true
                    }
                }
            }.resume()
        }
        fetchForcesSpecific(force: newForce)
    }
}



// Shh! You didn't see that!
func simulateImgUrlInJSON(id : String) -> String {
    if id == "avon-and-somerset" {
        return "https://i.postimg.cc/JnDNfN6T/avon-and-somerset.png"
    } else if id == "bedfordshire" {
        return "https://i.postimg.cc/0QTYPzh9/bedfordshire.png"
    } else if id == "cambridgeshire" {
        return "https://i.postimg.cc/nVmKT1Qr/cambridgeshire.png"
    } else if id == "cheshire" {
        return "https://i.postimg.cc/02qY4Jpf/cheshire.png"
    } else if id == "city-of-london" {
        return "https://i.postimg.cc/MH1yTW8V/city-of-london.png"
    } else if id == "cleveland" {
        return "https://i.postimg.cc/yYXmCYjz/cleveland.png"
    } else if id == "cumbria" {
        return "https://i.postimg.cc/6pWdWJb4/cumbria.png"
    } else if id == "derbyshire" {
        return "https://i.postimg.cc/VkKX5G2G/derbyshire.png"
    } else if id == "devon-and-cornwall" {
        return "https://i.postimg.cc/JhtZX3L1/devon-and-cornwall.png"
    } else if id == "dorset" {
        return "https://i.postimg.cc/FRLSW9z8/dorset.png"
    } else if id == "durham" {
        return "https://i.postimg.cc/7YDz9rkt/durham.png"
    } else if id == "dyfed-powys" {
        return "https://i.postimg.cc/yN59yJ10/dyfed-powys.png"
    } else if id == "essex" {
        return "https://i.postimg.cc/Y2QgQqJm/essex.png"
    } else if id == "gloucestershire" {
        return "https://i.postimg.cc/vHzVS28Y/gloucestershire.png"
    } else if id == "greater-manchester" {
        return "https://i.postimg.cc/VkkCy95j/greater-manchester.png"
    } else if id == "gwent" {
        return "https://i.postimg.cc/C5Cq0mj4/gwent.png"
    } else if id == "hampshire" {
        return "https://i.postimg.cc/prMF3gnT/hampshire.png"
    } else if id == "hertfordshire" {
        return "https://i.postimg.cc/4x2hXKhj/hertfordshire.png"
    } else if id == "humberside" {
        return "https://i.postimg.cc/nL6jQ62k/humberside.png"
    } else if id == "kent" {
        return "https://i.postimg.cc/d1r7R4SK/kent.png"
    } else if id == "lancashire" {
        return "https://i.postimg.cc/zfLHvJCv/lancashire.png"
    } else if id == "leicestershire" {
        return "https://i.postimg.cc/L5SJxLrg/leicestershire.png"
    } else if id == "lincolnshire" {
        return "https://i.postimg.cc/PfbpPVwW/lincolnshire.png"
    } else if id == "merseyside" {
        return "https://i.postimg.cc/Wz7hCtvW/merseyside.png"
    } else if id == "metropolitan" {
        return "https://i.postimg.cc/FsDYxfG1/metropolitan.png"
    } else if id == "norfolk" {
        return "https://i.postimg.cc/ncHs7K46/norfolk.png"
    } else if id == "north-wales" {
        return "https://i.postimg.cc/Dw08p2Y6/north-wales.png"
    } else if id == "north-yorkshire" {
        return "https://i.postimg.cc/nLQMZ3xQ/north-yorkshire.png"
    } else if id == "northamptonshire" {
        return "https://i.postimg.cc/vZKDppJs/northamptonshire.png"
    } else if id == "northern-ireland" {
        return "https://i.postimg.cc/3R5Nw2rf/northern-ireland.png"
    } else if id == "northumbria" {
        return "https://i.postimg.cc/j2RjHK7z/northumbria.png"
    } else if id == "nottinghamshire" {
        return "https://i.postimg.cc/KzPz34RG/nottinghamshire.png"
    } else if id == "south-wales" {
        return "https://i.postimg.cc/NGxFgy3b/south-wales.png"
    } else if id == "south-yorkshire" {
        return "https://i.postimg.cc/KjQ8QVPC/south-yorkshire.png"
    } else if id == "staffordshire" {
        return "https://i.postimg.cc/L66Xh9RS/staffordshire.png"
    } else if id == "suffolk" {
        return "https://i.postimg.cc/3xzJL2Gr/suffolk.png"
    } else if id == "surrey" {
        return "https://i.postimg.cc/FHYHgT7n/surrey.png"
    } else if id == "sussex" {
        return "https://i.postimg.cc/m2XrHv2H/sussex.png"
    } else if id == "thames-valley" {
        return "https://i.postimg.cc/bvbY4d0x/thames-valley.png"
    } else if id == "warwickshire" {
        return "https://i.postimg.cc/C1gM0YJW/warwickshire.png"
    } else if id == "west-mercia" {
        return "https://i.postimg.cc/nzGFc5PM/west-mercia.png"
    } else if id == "west-midlands" {
        return "https://i.postimg.cc/cC1sKmph/west-midlands.png"
    } else if id == "west-yorkshire" {
        return "https://i.postimg.cc/Xq2n953b/west-yorkshire.png"
    } else if id == "wiltshire" {
        return "https://i.postimg.cc/kMwJ00Sp/wiltshire.png"
    } else {
        return "nil"
    }
}
