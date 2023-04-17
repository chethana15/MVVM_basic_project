

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var imagesCV: UICollectionView!
    var getImagesViewModel = GetImagesViewModel()
    var imagesDetailsDictionary = [ImageDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagesCV.delegate = self
        imagesCV.dataSource = self
        self.imagesCV.register(UINib(nibName: "ImagesCVCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCVCell")
        
        initialSetUp()

        getImagesDetails()
    }
    func getImagesDetails(){
        
        
        getImagesViewModel.fetchImageDetails(success: { imagesResponse in
            
            self.imagesDetailsDictionary = [ImageDetails]()
            
            if let imageDetails = imagesResponse.ImageDetailsDictionary {
                print("imageDetails:\(imageDetails)")
                self.imagesDetailsDictionary = imageDetails

                //reload tableview once you get data
                self.imagesCV.reloadData()
            }
        }, failure: { error in
            print("Error fetching image details: \(error)")
        })
    }
    func initialSetUp(){
        
        //set up collectionview layout
        guard let collectionView = imagesCV, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
       
        let itemWidth = ((collectionView.frame.width/2))
        let itemHeight:CGFloat = itemWidth
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            flowLayout.itemSize =  CGSize(width: itemWidth, height: itemHeight)
        }
        else
        {
            if(UIScreen.main.nativeBounds.height == 960 || UIScreen.main.nativeBounds.height == 1136)
            {
                flowLayout.itemSize =  CGSize(width: itemWidth, height: itemHeight)
            }
            else
            {
                flowLayout.itemSize =  CGSize(width: itemWidth, height: itemHeight)
            }
        }
    }

    @IBAction func imagesBtnTap(_ sender: Any) {
//      when tapped on reload...call the api again so in this way no need to run the app again and again
        getImagesDetails()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesDetailsDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ImagesCVCell!
        cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVCell", for: indexPath) as? ImagesCVCell

        if(indexPath.row < imagesDetailsDictionary.count){
            let eachImageDetails = imagesDetailsDictionary[indexPath.row] as ImageDetails
            cell.imgTitleLbl.text = "\(eachImageDetails.title)"
            let img = eachImageDetails.image
           
            if let imageUrl = URL(string: img) {
                cell.img.kf.setImage(with: imageUrl, placeholder: UIImage(named: "noImage"), options: [.transition(.fade(1))], progressBlock: nil) { result in
                    switch result {
                    case .success(let downloadImage):
                        cell.img.image = downloadImage.image
                    case .failure(_):
                        break
                    }
                }
            } else {
                //make sure to keep an default image if url is not a proper one
                cell.img.image = UIImage(named: "noImage")
            }

        }

        return cell
    }
    
    
}

