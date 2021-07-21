//
//  TableDetailVC.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/18/21.
//

import UIKit
import Kingfisher
class TableDetailView: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var image:UIImageView!
    @IBOutlet private weak var Model:UILabel!
    @IBOutlet private weak var Driver:UILabel!
    @IBOutlet private weak var Color:UILabel!
    @IBOutlet private weak var FuelType:UILabel!
    @IBOutlet private weak var FuelLevel: UIProgressView!
    @IBOutlet private weak var Transmission:UILabel!
    @IBOutlet private weak var Cleanliness:UILabel!
    @IBOutlet private weak var Plate:UILabel!
    
    var ride : RideModel?
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        guard ride != nil else { return }
        image.kf.setImage(with: URL(string: ride!.image))
        Model.text = ride?.modelName
        Driver.text = ride?.name
        Color.text = ride?.color
        FuelType.text = ride?.fuelType
        FuelLevel.progress = ride?.fuelLvl ?? 1
        Transmission.text = ride?.transmission
        Cleanliness.text = ride?.cleanliness
        Plate.text = ride?.license
    }
}
