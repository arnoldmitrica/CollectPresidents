//
//  PresidentDetailViewController.swift
//  milestone3
//
//  Created by Arnold Mitricã on 15/11/2020.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: @escaping (UIImage?) -> ()){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                    }
                }
            }
        }
    }
}
protocol ImageDelegate:AnyObject{
    func imagereturn(type: UIImage?, index: Int?)
}

class PresidentDetailViewController: UIViewController{
        
    @IBOutlet var presidentimage: UIImageView!
    @IBOutlet var numberpresident: UILabel!
    @IBOutlet var namepresident: UILabel!
    @IBOutlet var birth: UILabel!
    @IBOutlet var death: UILabel!
    @IBOutlet var partyimage: UIImageView!
    @IBOutlet var left: UILabel!
    @IBOutlet var took: UILabel!
    
    weak var delegate:ImageDelegate?
    
    var birthday:String = ""
    var deathday:String = ""
    var tooktime:String = ""
    var lefttime:String = ""
    var namep:String = ""
    var numberp:String = ""
    var imagename: String = ""
    @IBOutlet var partyname: UILabel!
    var partynume:String = ""
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        birth.text = birthday
        death.text = deathday
        took.text = tooktime
        left.text = lefttime
        namepresident.text = namep
        numberpresident.text = numberp + "."
        partyname.text = partynume
        let urlfile = URL(string: imagename)
        if let urlfl = urlfile{
            presidentimage.load(url: urlfl) { [weak self] (image) in
                if let index = self?.index {
                    self?.delegate?.imagereturn(type: image, index: index)
                }
            }
        }

        partyimage.image = UIImage(named: partynume)
    }

}
