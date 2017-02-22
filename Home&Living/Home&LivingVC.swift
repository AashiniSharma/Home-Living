
import UIKit
import AlamofireImage


class Home_LivingVC: UIViewController {
  
    
    //MARK: Properties
    var favouritesIndicesArray = [[IndexPath]]()     //2D array for storing indexpaths of table view and collection view
    var hiddenElementsIndicesArray = [IndexPath]()  // array for storing show and hide elements
    var hiddenSectionsIndicesArray = [Int]()        // array for storing show and hide sections
    var picturesData = [[[ImageInfo]]]()            //array for storing images of collection view cell
    var sectionsLabelData : [String] = ["Kitchen","Home Decor","Curtains"] //array for storing sections label
   
    
    //MARK: IB Outlets
    @IBOutlet weak var home_LivingTableView: UITableView!
    

    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
         getImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Private Functions
    private func initialSetup(){
     
        //setting datasources and delegates for table view
        self.home_LivingTableView.dataSource = self
        self.home_LivingTableView.delegate = self
        
        
        //registering xib for table cell
        let xib = UINib(nibName: "SectionsforHome&Living", bundle: nil)
        home_LivingTableView.register(xib, forCellReuseIdentifier: "SectionsforHome_LivingID")
        
        //registering xib for header section in table view
        let nib = UINib(nibName: "TitlesOfSection", bundle: nil)
        home_LivingTableView.register(nib, forHeaderFooterViewReuseIdentifier: "TitlesOfSectionID")
        

    }
    
      private func getImage(){
        
        var count = 1
        for sections in sectionsLabelData{
            picturesData.append([])
            
            for _ in 0...4 {
         
                
                WebController().fetchDataFromPixabay(withQuery: sectionsLabelData[sections],
                                             page      : count,
                                             success: { (images : [ImageInfo]) in
                                                
            self.picturesData[sections].append(images)
                                                
            self.home_LivingTableView.reloadData()
                                                
        }) { (error : Error) in
            
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            print(error)
                }
                
                    count += 1
            }
           

        }
   
    }
    
}

//MARK: tableview delegates and datasources
extension Home_LivingVC : UITableViewDataSource,UITableViewDelegate {
    
    // return number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return picturesData.count
    }
    
    //return number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if hiddenSectionsIndicesArray.contains(section){
            return 0
        } else {
      
            return picturesData[section].count
        }
    }
    
    //returning table cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionsforHome_LivingID", for: indexPath) as? SectionsforHome_Living else {fatalError("Not Found")}
        
        cell.tableIndexpath = indexPath
        
        //setting datasources and delegates for collection view
        cell.home_LivingCollectionView.dataSource = self
        cell.home_LivingCollectionView.delegate = self
        
        //registering xib for collection view cell
        let nib = UINib(nibName: "VarietiesofHome_Living", bundle: nil)
        cell.home_LivingCollectionView.register(nib, forCellWithReuseIdentifier: "VarietiesofHome_LivingID")
        
        //MARK: IB Action of masking button
        cell.maskButtonOutlet.addTarget(self, action: #selector(maskingAction), for: .touchUpInside)
        
        //persistency for masking and unmasking
        if hiddenElementsIndicesArray.contains(indexPath){
            
            cell.maskButtonOutlet.isSelected = true
            
        }else {

            cell.maskButtonOutlet.isSelected = false

        }
        
             return cell
        
    }
    
    //returning height of row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if hiddenElementsIndicesArray.contains(indexPath){
            
                return 30
            
            } else {
            
                return 125
        }
    }
    
    //returning height of header section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //returning the title of header section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitlesOfSectionID") as? TitlesOfSection else { return nil}
    
        header.maskingSectionButtonOutlet.addTarget(self, action: #selector(maskingSectionButtonAction), for: .touchUpInside)
        
        header.maskingSectionButtonOutlet.tag = section
        
        if hiddenSectionsIndicesArray.contains(section){
            
            header.maskingSectionButtonOutlet.isSelected = true
            
        } else {
            
            header.maskingSectionButtonOutlet.isSelected = false

        }
        
        header.titlesOutlet.text = sectionsLabelData[section]
        
       return header
        
    }
    
    //function of masking elements button
    func maskingAction (button : UIButton){
        
        guard let cell = button.tableViewCell as? SectionsforHome_Living else { return }
        
        if button.isSelected {
            
            hiddenElementsIndicesArray = hiddenElementsIndicesArray.filter(){ (index: IndexPath) -> Bool in
            return index != home_LivingTableView.indexPath(for: cell)
            }
        
            button.isSelected = false
            
        } else {
            
            hiddenElementsIndicesArray.append(home_LivingTableView.indexPath(for: cell)!)
            
            button.isSelected = true
        }
        
        home_LivingTableView.reloadRows(at: [home_LivingTableView.indexPath(for: cell)!] , with: .fade )
      
        }
    //function of masking sections
    func maskingSectionButtonAction(button : UIButton) {
   
        if button.isSelected{
            
            button.isSelected = false
            hiddenSectionsIndicesArray = hiddenSectionsIndicesArray.filter(){$0 != button.tag}
            
        }else{
            
            button.isSelected = true
            hiddenSectionsIndicesArray.append(button.tag)
          
        }
        
        home_LivingTableView.reloadSections([button.tag], with: .fade)
       
       }
   
}


// MARK: collection view datasources and delegates
extension Home_LivingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //returning number of items in a particular section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let tableCell = collectionView.tableViewCell as! SectionsforHome_Living
        return picturesData[tableCell.tableIndexpath.section][tableCell.tableIndexpath.row].count
    }
    
    //returning the cell of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VarietiesofHome_LivingID", for: indexPath) as? VarietiesofHome_Living else {fatalError("Not Found")
        }
        //MARK: IB Action of favourites button
        cell.favouritesButtonOutlet.addTarget(self, action: #selector(favouritesButtonAction), for: .touchUpInside)
        
        //fetching table cell
        let tableCell = collectionView.tableViewCell as! SectionsforHome_Living
        
        //
        let data = picturesData[tableCell.tableIndexpath.section][tableCell.tableIndexpath.row][indexPath.row]
        
        if let url = URL(string: data.previewURL) {
            
           cell.varietiesImages.af_setImage(withURL : url)
        
        
        }
        
        cell.varietyLabel.text = "\(tableCell.tableIndexpath.section).\(tableCell.tableIndexpath.row).\(indexPath.row)"
        
        if favouritesIndicesArray.contains(where: { (indices : [IndexPath]) -> Bool in
            return indices == [tableCell.tableIndexpath,indexPath]
        }){
            
            cell.favouritesButtonOutlet.isSelected = true
        }else{
            
            cell.favouritesButtonOutlet.isSelected = false
            
        }
        
           return cell
     }
    
    // push the image on other view while selecting on it
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let popUpImagePage = self.storyboard?.instantiateViewController(withIdentifier: "PopupImageVCID") as? PopupImageVC else { return }
        let tableCell = collectionView.tableViewCell as! SectionsforHome_Living

        let data = picturesData[tableCell.tableIndexpath.section ][tableCell.tableIndexpath.row][indexPath.row]
         popUpImagePage.imageUrl = URL(string: data.webformatURL)
        
        UIView.animate(withDuration: 0.5, animations: {
        
        self.navigationController!.pushViewController(popUpImagePage, animated: false)
                
        })
    }
    
    //function of favourites button
    func favouritesButtonAction(button : UIButton) {
        
        //finding indexpath of table cell
        guard let tableCell = button.tableViewCell as? SectionsforHome_Living else { return }
        let tableIndexpath = home_LivingTableView.indexPath(for: tableCell)
        
        //finding indexpath of collection cell
        guard let collectionCell = button.collectionViewCell as? VarietiesofHome_Living else { return }
        let collectionIndexpath = tableCell.home_LivingCollectionView.indexPath(for: collectionCell)
        
        if button.isSelected == false{
           
            favouritesIndicesArray.append([tableIndexpath!,collectionIndexpath!])
             print(favouritesIndicesArray)
            
            button.isSelected = true
          
        } else {
            
            favouritesIndicesArray = favouritesIndicesArray.filter(){ (indices: [IndexPath]) -> Bool in
                return indices != [tableIndexpath!,collectionIndexpath!]

            }
            button.isSelected = false
            
        }
     }
}

    
