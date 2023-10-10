//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Juan Andrés Cervantes Guati Rojo on 09/10/23.
//

import UIKit
import SDWebImage
import SafariServices

class CharacterDetailViewController: UIViewController {
    
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterName: UILabel!
    @IBOutlet var characterDescription: UILabel!
    
    @IBOutlet var tableView: UITableView!
    var characterReceived: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        let urlThumbnail = URL(string: (characterReceived?.thumbnail.url)!)
        
        characterImage.sd_setImage(with: urlThumbnail)
        
        characterName.text = characterReceived?.name
        
        if ((characterReceived?.description.isEmpty)!) {
            characterDescription.text = "(No description)"
        }else {
            characterDescription.text = characterReceived?.description
        }
        
        
        /*for url in characterReceived!.urls {
            print("-*-*-*-*-*-*-*-*-*\n", url.type)
            print(url.url)
            
        }*/
        
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (characterReceived?.urls.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath) as! LinkCell
        
        cell.linkLabel.text = characterReceived?.urls[indexPath.row].type
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: characterReceived!.urls[indexPath.row].url)
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariController = SFSafariViewController(url: url!,configuration: config)
        self.present(safariController, animated: true)
    }
    
    
}
