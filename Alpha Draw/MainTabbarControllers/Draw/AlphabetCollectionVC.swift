//
//  AlphabetCollectionVC.swift
//  Alpha Draw
//
//  Created by Siam on 4/24/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit
import AVFoundation

class AlphabetCollectionVC: UIViewController {

    @IBOutlet var alphabetCollection: UICollectionView!
    
    let cellIdentifier = "AlphabetCell"
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var alphabetList:[String] = []
    
    var player: AVPlayer!
    
    //MARK: view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    //MARK: Setup
    func setup()
    {
        setupCollectionView()
        initAlphabetList()
    }
    
    func initAlphabetList()
    {
        alphabetList = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                        "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    }
    
    //MARK: CollectionView
    private func setupCollectionView()
    {
        alphabetCollection.delegate = self
        alphabetCollection.dataSource = self
        
        let nib = UINib(nibName: "AlphabetCell", bundle: nil)
        alphabetCollection.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil{
            let numberofItemPerRow:CGFloat = 3
            let lineSpacing:CGFloat = 5.0
            let interItemSpacing:CGFloat = 5.0
            
            let width = (alphabetCollection.frame.width - (numberofItemPerRow - 1)  * interItemSpacing) / numberofItemPerRow
            
            let height = width  // as item image ratio
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            alphabetCollection.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    
    //MARK: playSound
    func playSound(filename:String,fileExtension:String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            print("error to get the mp3 file")
            return
        }

        do {
            player = try AVPlayer(url: url)
        } catch {
            print("audio file error")
        }
        player?.play()
    }
    
    func startDrawing(letter:String)
    {
        let sb = UIStoryboard(name: "Draw", bundle: nil)
        
        let drawVC = sb.instantiateViewController(withIdentifier: "DrawLetterVC") as! DrawLetterVC
        drawVC.drawingLetter = letter
        self.navigationController?.pushViewController(drawVC, animated: true)
    }
    

}

extension AlphabetCollectionVC : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AlphabetCell
        
        let letter = alphabetList[indexPath.row]
        cell.letterName.text = letter
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let letter = alphabetList[indexPath.row]
        startDrawing(letter: letter)
        
//        let audioSound = letter.lowercased()
//        playSound(filename: audioSound, fileExtension: "mp3")
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    
}
