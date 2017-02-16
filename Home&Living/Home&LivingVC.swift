//
//  Home&LivingVC.swift
//  Home&Living
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class Home_LivingVC: UIViewController {

    @IBOutlet weak var home_LivingOutlet: UITableView!
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.home_LivingOutlet.dataSource = self
        self.home_LivingOutlet.delegate = self
        
        let xib = UINib(nibName: "SectionsforHome&Living", bundle: nil)
        home_LivingOutlet.register(xib, forCellReuseIdentifier: "SectionsforHome_LivingID")
        

        let nib = UINib(nibName: "TitlesOfSection", bundle: nil)
        home_LivingOutlet.register(nib, forHeaderFooterViewReuseIdentifier: "TitlesOfSectionID")
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

//MARK: tableview delegates and datasources
extension Home_LivingVC : UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionsforHome_LivingID", for: indexPath) as! SectionsforHome_Living
        
        cell.collectionsofBrands.dataSource = self
        
        let nib = UINib(nibName: "VarietiesofHome_Living", bundle: nil)
        cell.collectionsofBrands.register(nib, forCellWithReuseIdentifier: "VarietiesofHome_LivingID")
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitlesOfSectionID")
        return header
        
    }
    
}

extension Home_LivingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VarietiesofHome_LivingID", for: indexPath) as? VarietiesofHome_Living else {fatalError("Not Found") }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 90)
    }
    
}

