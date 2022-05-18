//
//  ViewController.swift
//  udemy_firebase_filmler
//
//  Created by Eren Demir on 18.05.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var kategorilerTableView: UITableView!
    var kategorilerListe = [Kategoriler]()
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        kategorilerTableView.delegate = self
        kategorilerTableView.dataSource = self
        tumKategoriler()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilm" {
            print("toFilm")
            if let index = sender as? Int{
                let gidilecekVC = segue.destination as! FilmViewController
                gidilecekVC.kategori = kategorilerListe[index]
            }
        }
    }
    
    func tumKategoriler() {
        ref.child("kategoriler").observe(.value, with: { snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.kategorilerListe.removeAll()
                for gelenSatirVerisi in gelenVeriButunu {
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary {
                        let key = gelenSatirVerisi.key
                        let kategori_ad = sozluk["kategori_ad"] as? String ?? ""
                        let kategori = Kategoriler(kategori_id: key, kategori_ad: kategori_ad)
                        self.kategorilerListe.append(kategori)
                    }
                }
                DispatchQueue.main.async {
                    self.kategorilerTableView.reloadData()
                }
            }
        })
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gelenKategori = kategorilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriHucre", for: indexPath) as! KategoriTableViewCell
        cell.kategoriAdLabel.text = gelenKategori.kategori_ad
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
}
