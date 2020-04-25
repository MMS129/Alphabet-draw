//
//  DrawLetterVC.swift
//  Alpha Draw
//
//  Created by Siam on 4/25/20.
//  Copyright © 2020 Siam. All rights reserved.
//

import UIKit

class DrawLetterVC: UIViewController {
    
    var drawingLetter:String = ""

    @IBOutlet var targetLetter: UILabel!
    @IBOutlet var canvas: Canvas!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup()
    {
        targetLetter.text = drawingLetter
    }
    
    //MARK:IBA
    @IBAction func undo(_ sender: Any) {
        canvas.undo()
    }
    @IBAction func redo(_ sender: Any) {
        canvas.redo()
    }
    @IBAction func clear(_ sender: Any) {
        canvas.clear()
    }
    @IBAction func confirm(_ sender: Any) {
        
    let drawnImage = self.image(with: self.canvas)
        
    }
    //MARK: internal method
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
}
