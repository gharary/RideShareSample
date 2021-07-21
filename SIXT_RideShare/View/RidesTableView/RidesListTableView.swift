//
//  RidesListTableView.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/18/21.
//

import UIKit


extension RideView:UITableViewDataSource, UITableViewDelegate {
    
    /// return number of rows, `No data` if there is no item to show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rides.count == 0 {
            tableView.setEmptyMessage("No data...")
            return 0
        } else {
            tableView.restore()
            return rides.count
        }
    }
    
    /// config each row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RideCell

        
        cell.rideModel.text = rides[indexPath.row].modelName
        cell.name.text = "Driver: " + rides[indexPath.row].name
        cell.make.text = rides[indexPath.row].make
        let url = URL(string: rides[indexPath.row].image)
        cell.rideImage.kf.indicatorType = .activity
        cell.rideImage.kf
            .setImage(with: url, placeholder: UIImage(named: "fallback"), options: [.transition(.fade(1)),.cacheOriginalImage])
        return cell
        
        
    }
    
    
    /// fixed height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    /// call segue whenever a cell selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRideDetail", sender: self)
    }
    
}

/// An extension for the empty state of the table.
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        
    }
    
    func restore() {
        self.backgroundView = nil
        
    }
}

