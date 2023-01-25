//
//  SearchViewController.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 30.11.2022.
//

import UIKit

class SearchViewController: UIViewController {

    let service : ServiceAPI
    var array : [Title] = []
    
    let upcomingMoviesTable : UITableView = {
        let table = UITableView()
        table.register(UpcomingTableViewCell.self, forCellReuseIdentifier: "UpcomingTableViewCell")
        return table
    }()
    
    let searchBar : UISearchController = {
        let searchBar = UISearchController(searchResultsController: SearchResultViewController())
        searchBar.searchBar.placeholder = "Search Movie"
        searchBar.searchBar.searchBarStyle = .prominent
        return searchBar
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.searchController = searchBar
        view.addSubview(upcomingMoviesTable)
        
        upcomingMoviesTable.delegate = self
        upcomingMoviesTable.dataSource = self
        
        service.getDiscoverMovies { result in
            switch result{
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.array = response.results
                    self?.upcomingMoviesTable.reloadData()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        searchBar.searchResultsUpdater = self
    }
    
    init(service : ServiceAPI)
    {
        self.service = service
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        upcomingMoviesTable.frame = view.bounds
    }
    
    
    
    
}


extension SearchViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = upcomingMoviesTable.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
        
        cell.configure(with: array[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

extension SearchViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count > 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {return}
        
        service.search(with: query) { result in
            DispatchQueue.main.async {
                switch result
                {
                    
                case .success(let resultArray):
                    resultController.titles = resultArray.results
                    resultController.searchResultCollectionView.reloadData()
                case .failure(let fail):
                    print(fail.localizedDescription)
                }
            }
        }
        
        
        
              
              
        
        
    }
    
    
}
