
import UIKit

class Home_LivingVC: UIViewController {
    //MARK: IB Outlets
    @IBOutlet weak var home_LivingOutlet: UITableView!
    
    var favouritesArray = [[IndexPath]]()
    
    var hiddinElements = [IndexPath]()
    
    
 
    
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
        
    }
  
}

//MARK: tableview delegates and datasources
extension Home_LivingVC : UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionsforHome_LivingID", for: indexPath) as! SectionsforHome_Living
        
        cell.collectionofBrands.dataSource = self
        cell.collectionofBrands.delegate = self

        let nib = UINib(nibName: "VarietiesofHome_Living", bundle: nil)
        cell.collectionofBrands.register(nib, forCellWithReuseIdentifier: "VarietiesofHome_LivingID")
        
        cell.maskButtonOutlet.addTarget(self, action: #selector(maskingAction), for: .touchUpInside)
        if hiddinElements.contains(indexPath){
            cell.maskButtonOutlet.isSelected = true
        }
        else{
            cell.maskButtonOutlet.isSelected = false

        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if hiddinElements.contains(indexPath){
            return 30
            }
        else{
        return 125
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitlesOfSectionID")
        return header
        
    }
    
    func maskingAction (button : UIButton){
        
        let cell = UIView.getSuperView(givenObject : button, designatedSuperView : .UITableViewCell) as! SectionsforHome_Living
        
        
        if button.isSelected {
        
            hiddinElements.remove(at: hiddinElements.index(of:(home_LivingOutlet.indexPath(for: cell)!))!)
//            UIView.animate(withDuration: 1.0, animations: {
//              
//                UIView.setAnimationTransition(.flipFromRight, for: cell, cache: false)
//              })
//
            button.isSelected = false
                       }

        else{
            
           hiddinElements.append(home_LivingOutlet.indexPath(for: cell)!)
//            UIView.animate(withDuration: 1.0, animations: {
//           
//            UIView.setAnimationTransition(.flipFromLeft, for: cell, cache: false)
//                
//            })
//
            button.isSelected = true
            }
        home_LivingOutlet.reloadRows(at: [home_LivingOutlet.indexPath(for: cell)!] , with: .fade )
      
        }
    }
    

    

// MARK: collection view datasources and delegates
extension Home_LivingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VarietiesofHome_LivingID", for: indexPath) as? VarietiesofHome_Living else {fatalError("Not Found")
        }
                cell.favouritesButtonOutlet.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
                return cell
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let popUpImagePage = self.storyboard?.instantiateViewController(withIdentifier: "PopupImageVCID") as! PopupImageVC
        let  cell = collectionView.cellForItem(at: indexPath) as! VarietiesofHome_Living
        
        popUpImagePage.image = cell.brandVarietiesImages.backgroundColor!
        
        UIView.animate(withDuration: 0.33, animations: {
        
        UIView.setAnimationCurve(.easeInOut)
        
        self.navigationController!.pushViewController(popUpImagePage, animated: true)
        UIView.setAnimationTransition(.curlUp, for: self.navigationController!.view!, cache: false)
        
        })
    }
    
    
    func buttonAction(button : UIButton) {
        
        
        let tableCell = UIView.getSuperView(givenObject : button, designatedSuperView : .UITableViewCell) as! SectionsforHome_Living
        let tableIndexpath = home_LivingOutlet.indexPath(for: tableCell)
        
        let collectionCell = UIView.getSuperView(givenObject : button, designatedSuperView : .UICollectionViewCell) as! VarietiesofHome_Living
        
        let collectionIndexpath = tableCell.collectionofBrands.indexPath(for: collectionCell)
        
        
        if button.isSelected == false{
           
            favouritesArray.append([tableIndexpath!,collectionIndexpath!])
             print(favouritesArray)
            
            button.isSelected = true
//           button.isSelected = false
        }
        else {
            
            favouritesArray.remove(at: favouritesArray.index(where: { (a : [IndexPath]) -> Bool in
             return a == [tableIndexpath!,collectionIndexpath!]
               })!)
             button.isSelected = false
            
        }
     }

}

    
