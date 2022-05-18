//
//  FilmCollectionViewCell.swift
//  udemy_sqlfilmler
//
//  Created by Eren Demir on 11.05.2022.
//

import UIKit

protocol FilmHucreCollectionViewCellProtocol {
    func sepeteEkleFunc(indexPath:IndexPath)
}

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filmAdLabel: UILabel!
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmFiyatLabel: UILabel!
    var hucreProtocol: FilmHucreCollectionViewCellProtocol?
    var indexPath:IndexPath?
    
    @IBAction func sepeteEkle(_ sender: Any) {
        hucreProtocol?.sepeteEkleFunc(indexPath: self.indexPath!)
    }
}
