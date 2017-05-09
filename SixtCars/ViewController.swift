//
//  ViewController.swift
//  SixtCars
//
//  Created by Ravi on 08/05/17.
//  Copyright © 2017 ThinkAnts. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var carsTableView: UITableView!
    
    let urlString = URL(string: "http://www.codetalk.de/cars.json")
    var carList:[AnyObject] = []
    let cellReuseIdentifier = "carsList"
    let cellSpacingHeight: CGFloat = 157
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        carsTableView.register(UINib.init(nibName: "CarsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        carsTableView.backgroundColor = UIColor.clear

        fetchCarsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCarsList() {
          let urlRequest = URLRequest(url: urlString!)
        dataTask(request: urlRequest as NSURLRequest) { [weak weakself = self] (success, object) in
            if success == true {
                weakself?.carList = object as! [AnyObject]
                if (weakself?.carList.count)! > 0 {
                    weakself?.carsTableView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Table view data source & delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carList.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CarsTableViewCell else {
            return UITableViewCell()
        }
        
        var carDetails = CarsList()
        carDetails = Mapper<CarsList>().map(JSONObject: carList[indexPath.row])!
        
        cell.licenseLabel.text = carDetails.licensePlate
        cell.fuelTypeLabel.text = carDetails.fuelType
        cell.transmissionLabel.text = carDetails.transmission
        cell.ownerLabel.text = carDetails.name
        cell.carModelLabel.text = (carDetails.make) + "-" + (carDetails.group)
        cell.vinLabel.text = carDetails.id
         let imageString = String(format: "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/%@/%@/2x/car.png", (carDetails.modelIdentifier),(carDetails.color))
        let url = URL(string: imageString)
        
        do {
            let data = try Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.carImage.image = UIImage(data: data)
            }

        } catch {
            print(error.localizedDescription)
        }
        
        return cell
    }

}

