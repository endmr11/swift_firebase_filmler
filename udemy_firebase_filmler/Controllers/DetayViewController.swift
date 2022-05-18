//
//  DetayViewController.swift
//  udemy_sqlfilmler
//
//  Created by Eren Demir on 11.05.2022.
//

import UIKit

class DetayViewController: UIViewController {

    @IBOutlet weak var detayFilmImageView: UIImageView!
    @IBOutlet weak var detayFilmAdLabel: UILabel!
    @IBOutlet weak var detayFilmTarihLabel: UILabel!
    @IBOutlet weak var detayFilmKategoriLabel: UILabel!
    @IBOutlet weak var detayFilmYonetmenLabel: UILabel!
    var film: Filmler?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let f = film {
            navigationItem.title = f.film_ad
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film!.film_resim!).png"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.detayFilmImageView.image = UIImage(data:data!)
                    }
                }
            }
            
            detayFilmAdLabel.text = f.film_ad
            detayFilmTarihLabel.text = "\(f.film_yil!)"
            detayFilmKategoriLabel.text = f.kategori_ad
            detayFilmYonetmenLabel.text = f.yonetmen_ad
        }
    }
    



}
