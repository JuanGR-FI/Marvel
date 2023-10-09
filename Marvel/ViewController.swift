//
//  ViewController.swift
//  Marvel
//
//  Created by Juan Andrés Cervantes Guati Rojo on 30/09/23.
//

import UIKit
import SDWebImage
import SafariServices

class ViewController: UIViewController {
    
    let myKeys = KeyLoader.shared
    let characterService = CharacterService()
    var selectedCharacter: Character?

    @IBOutlet var characterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        
        
        
        print("qs: ", myKeys.getQueryString())
        
        characterService.loadCharactersData(queryString: myKeys.getQueryString(limit: Constants.numberOfItemsRequested, offset: Constants.initialOffset)){
            //print("loaded characters... ")
            DispatchQueue.main.async {
                self.characterCollectionView.reloadData()
            }
        }
        
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func backSegue(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func marvelUrlPressed(_ sender: UIButton) {
        
        let url = URL(string: "http://marvel.com")
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariController = SFSafariViewController(url: url!,configuration: config)
        self.present(safariController, animated: true)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacter = characterService.getCharacter(at: indexPath.row)
        //print(selectedCharacter.name)
        self.performSegue(withIdentifier: "detailSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CharacterDetailViewController
        destination.characterReceived = selectedCharacter
    }
    
    
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        size of scrollview content
        //print("contentSize.height", scrollView.contentSize.height)
        //        screen's available space for scrollview element
        //print("bounds.height:", scrollView.bounds.height)
        //        how much the content inside the scroll view has been scrolled vertically
        //print("contentOffset y:", scrollView.contentOffset.y)
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollviewHeight = scrollView.bounds.height
        
        if (offsetY > (contentHeight - scrollviewHeight)) && (!characterService.maxItemsLoaded && !characterService.isLoading ){
            //print("calling API...")
            self.characterService.isLoading = true
            let queryString = myKeys.getQueryString(limit: Constants.numberOfItemsRequested, offset: self.characterService.offset)
            
            self.characterService.loadCharactersData(queryString: queryString){
                DispatchQueue.main.async {
                    self.characterCollectionView.reloadData()
                    
                    self.characterService.offset = self.characterService.countCharacter()
                    self.characterService.isLoading = false
                }
            }
        }
        else{
            print("Don't call API...")
        }
    }
}
