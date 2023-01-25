//
//  HomeViewController.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 30.11.2022.
//

import UIKit

enum Sections: Int{
    case TrendingMovies = 0
    case Populer = 1
    case TrendingTv = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {

    let service : ServiceAPI
    private let headers = ["Trending","Populer","trending tv","upcoming","top rated"]
    private let homeFeedTableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
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
        view.addSubview(homeFeedTableView)
        view.backgroundColor = .systemBackground
        
        //homeFeedTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400)) // bu table için header ekleme kısmı bak bu güzelmiş. buraya bir adet colleciton view koyup slider yapabilirim...
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        configureNavbar()
        let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTableView.tableHeaderView = headerView
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
    
    private func configureNavbar()
    {
        
        let navbarImage  = UIImage(named: "netflixLogo")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resizeTo(size: CGSize(width: 25, height: 25))
      

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: navbarImage, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}






extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    //grouped olarak verdikten sonra her satırın bir headeri olması için bu alltakinde verdim kaç adet row olacağını.
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        header.textLabel?.frame = CGRect(x: view.bounds.origin.x + 20, y: view.bounds.origin.y, width: 100, height: view.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text? = (header.textLabel?.text?.lowercased())!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
       
    
        switch indexPath.section
        {
        case Sections.Populer.rawValue:
            service.getPopulerMovies { result in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    cell.configure(with: response.results)
                }
            }
        case Sections.TrendingMovies.rawValue:
            service.getTrendingMovies{ result in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    cell.configure(with: response.results)
                }
            }
        case Sections.TrendingTv.rawValue:
            service.getTrendingTv{ result in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    cell.configure(with: response.results)
                }
            }
        case Sections.TopRated.rawValue:
            service.getTopRatedMovies{ result in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    cell.configure(with: response.results)
                }
            }
        case Sections.Upcoming.rawValue:
            service.getUpcomingMovies{ result in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    cell.configure(with: response.results)
                }
            }
        default:
            print("default")
        }
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("at the top")
    }
    

}

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}



//TODO: tableview layout olarak veremedim bunu araştır. 
