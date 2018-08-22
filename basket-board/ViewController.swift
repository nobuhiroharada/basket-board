//
//  ViewController.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import UIKit
import SpriteKit
import ReplayKit

class ViewController: UIViewController {


    @IBOutlet weak var skview: SKView!
    @IBOutlet weak var toolBar: UIToolbar!
    var initSize: CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        skview?.showsFPS = true
//        skview?.showsNodeCount = true
        loadViews()
        toolBar.clipsToBounds = true
        
    }

    func loadViews() {
        let board = TopScene(size: skview.bounds.size)
        print(UIScreen.main.bounds)
        print(view.frame.size)
        print(skview.frame.size)
        print(skview.bounds.size)
        skview.presentScene(board)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        loadViews()
    }

    @IBAction func setFormation(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "フォーメーション", message: "フォーメーションを指定してください。", preferredStyle: .actionSheet)
        
        let twoThreeAction = UIAlertAction(title: "2-3", style: .default, handler: actionSheetChoose(sender:))
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
            print("キャンセルしました")
        })
        
        actionSheet.addAction(twoThreeAction)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)

    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        
    }
    
    func actionSheetChoose(sender: UIAlertAction) {
        skview.presentScene(nil)

        let formation = TwoThreeScene(size: skview.bounds.size)
        skview.presentScene(formation)
    }
}
