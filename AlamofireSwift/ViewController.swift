//
//  ViewController.swift
//  AlamofireSwift
//
//  Created by Deniz Ata Eş on 6.01.2023.
//

import UIKit

class ViewController: UIViewController {
    var dogList = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDogList()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getDogList(){
        NetworkingManager.shared.getDogList {[weak self] result in
            switch(result){
            case .success(let dog):
                self?.dogList = dog
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dogList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return dogList.count
    }

}
