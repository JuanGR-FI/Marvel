//
//  ViewController.swift
//  Marvel
//
//  Created by Juan Andrés Cervantes Guati Rojo on 30/09/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    let myKeys = KeyLoader.shared
    let characterService = CharacterService()

    @IBOutlet var characterCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        
        print("qs: ", myKeys.getQueryString())
        
        characterService.loadCharactersData(queryString: myKeys.getQueryString()){
            //print("loaded characters... ")
            DispatchQueue.main.async {
                self.characterCollectionView.reloadData()
            }
        }
        
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterService.countCharacter()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCell
        
        cell.characterLabel.text = characterService.getCharacter(at: indexPath.row).name
        
        let urlThumbnail = URL(string: characterService.getCharacter(at: indexPath.row).thumbnail.url)
        
        cell.characterImage.sd_setImage(with: urlThumbnail)
        
        return cell
    }
    
    
}
