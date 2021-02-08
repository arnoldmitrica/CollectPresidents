//
//  ViewController.swift
//  milestone3
//
//  Created by Arnold Mitricã on 15/11/2020.
//


import UIKit

class ViewController: UICollectionViewController, ImageDelegate {
    
    
    var presidents = [President]()
    var indexul: Int?
    var numberpresident: Int?
    var imaginepress: UIImage?
    private let cache = NSCache<NSNumber, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Presidents of USA"
        parse(jsonData: readLocalFile(forName: "presidentss")!)
        // Do any additional setup after loading the view.
    }
    
    func imagereturn(type: UIImage?, index: Int?) {
        if let img = type{
            if let indexul = index {
                cacheimage(img, indexul)
            }
        }
    }
    
    func cacheimage(_ img:UIImage,_ index: Int){
        cache.setObject(img, forKey: index as NSNumber)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presidents.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "President", for: indexPath) as? PresidentCollectionViewCell else{
            fatalError("Eroare fatala de la Presidentcollectionviewcell")
        }

        let presidentul = presidents[indexPath.item]
        
        cell.numberpresident.text = String(presidentul.number)
        if let imaginea = cache.object(forKey: indexPath.item as NSNumber){
            cell.presidentimage?.image = imaginea
        }
        else{
            cell.presidentimage?.image = nil
        }
        cell.namepresident.text = String(presidentul.president)
        return cell
    }
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PresidentDetail") as! PresidentDetailViewController
        let presidentul = presidents[indexPath.item]
        vc.delegate = self
        vc.birthday = String(presidentul.birth_year)
        vc.namep = String(presidentul.president)
        vc.tooktime = String(presidentul.took_office)
        vc.numberp = String(presidentul.number)
        vc.imagename = presidentul.image
        vc.partynume = presidentul.party
        vc.index = indexPath.item
        if let death = presidentul.death_year{
            vc.deathday = String(death)
        }else{
            vc.deathday = "Still alive"
        }
        if let left = presidentul.left_office{
            vc.lefttime = left
        }
        else{
            vc.lefttime = "It is still at the office"
        }
        vc.title = vc.namep
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("fatal error readlocalfile")
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        
        if let jsonPresidents = try? JSONDecoder().decode([President].self, from: jsonData) {
            presidents = jsonPresidents
        }
        else{
            print("decode errossr")
        }
    }


}
