//
//  ViewController.swift
//  Pokemon Table
//
//  Created by Consultant on 5/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var PokemonTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.prefetchDataSource = self
        table.backgroundColor = .white
        table.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseId)
        return table
    }()
    
    var pokemonset = 0
    var max_pokemon_amount = 120
    var pokemon_list: [Basic_Data] = []
    //var nextPage = ""
    let networkManager = NetworkManager()
    var poke_attr: [Int:PokemonModel] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pokdex"
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        view.addSubview(self.PokemonTableView)
        
        SetupTable()
        catchPokemon()
    }
    
    func SetupTable(){
        self.PokemonTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.PokemonTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.PokemonTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.PokemonTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func catchPokemon() {
        self.networkManager.engagePokemon(poke_set: self.pokemonset){[weak self] result in
            switch result {
            case .success(let page):
                self?.pokemon_list.append(contentsOf: page.results)
                //self.nextPage = page.next ?? ""
                DispatchQueue.main.async {
                    self?.PokemonTableView.reloadData()
                }
                
            case .failure(let err):
                print("Error: \(err.localizedDescription)")
                self?.presentErrorAlert(title: "NetworkError", message: err.localizedDescription)
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemon_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseId, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(poke_link: self.pokemon_list[indexPath.row]){
            result in
            if self.poke_attr[indexPath.row] == nil{
                self.poke_attr[indexPath.row] = result
            }
        }
        
        return cell
    }
   
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = PokemonDetailViewController()
        detailsView.poke_data = poke_attr[indexPath.row]
        self.present(detailsView, animated: true)
    }
        
}

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let lastIndexPath = IndexPath(row: self.pokemon_list.count - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
        
        if self.pokemonset < max_pokemon_amount {
            self.pokemonset += 30
            self.catchPokemon()
        }
        
    }
}

