//
//  UpcomingViewController.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 30.11.2022.
//

import UIKit

class UpcomingViewController: UIViewController {

    let service : ServiceAPI
    var array : [Title] = []
    
    let upcomingMoviesTable : UITableView = {
        let table = UITableView()
        //table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(UpcomingTableViewCell.self, forCellReuseIdentifier: "UpcomingTableViewCell")
        return table
    }()
    
    init(service : ServiceAPI)
    {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingMoviesTable)
        upcomingMoviesTable.delegate = self
        upcomingMoviesTable.dataSource = self
        service.getUpcomingMovies { result in
            switch result{
                
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.array = response.results
                    self?.upcomingMoviesTable.reloadData()
                }
            case .failure(_):
                print("error")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingMoviesTable.frame = view.bounds
    }
    

}


extension UpcomingViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = upcomingMoviesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = upcomingMoviesTable.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: array[indexPath.row])
        //cell.textLabel?.text = array[indexPath.row].original_title ?? "on"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
