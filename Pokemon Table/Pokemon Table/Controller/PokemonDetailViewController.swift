//
//  PokemonDetailViewController.swift
//  Pokemon Table
//
//  Created by Consultant on 5/7/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    let pokemonImageView1:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        img.image = UIImage(named: "question-mark") //Took from you as image holder
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokemon name"
        label.textAlignment = .center
        label.font = UIFont(name:"Courier", size: 20.0)
        label.textColor = .black
        return label
    }()
    
    let abilities_poke:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokemon types"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name:"Courier", size: 15.0)
        label.textColor = .black
        return label
    }()
    
    let moves_poke:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Type"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name:"Courier", size: 15.0)
        label.textColor = .black
        return label
    }()
    
    let discriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Write a Discription about the pokemon, give area and if it has any evolution also give height and wieght "
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name:"Courier", size: 15.0)
        label.textColor = .black
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    var poke_data: PokemonModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        guard let img_url = poke_data?.sprites.front_default else {
            return
        }
        
        guard let name = self.poke_data?.name else {
            return
        }
        self.nameLabel.text = name
        self.set_image(img_url: img_url)
        self.set_details()
        self.pokemon_moves()
        self.pokemon_abilities()

        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 4
        
        let topBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)
        let bottomBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)

        vStack.addArrangedSubview(topBuffer)
        vStack.addArrangedSubview(self.nameLabel)
        vStack.addArrangedSubview(self.pokemonImageView1)
        vStack.addArrangedSubview(self.discriptionLabel)
        vStack.addArrangedSubview(self.moves_poke)
        vStack.addArrangedSubview(self.abilities_poke)
        vStack.addArrangedSubview(bottomBuffer)
        
        self.scrollView.addSubview(vStack)
        self.view.addSubview(self.scrollView)
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true

        vStack.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        vStack.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        vStack.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true

        self.pokemonImageView1.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.pokemonImageView1.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func set_image(img_url: String){
        guard let img = ImageCache.shared.getImageData(key: img_url) else {
            return
        }
        
        self.pokemonImageView1.image = UIImage(data:img)
        
        
    }
    
    private func set_details(){
        var type_string = ""
        guard let name = poke_data?.name else{
            return
        }
        
        guard let height = poke_data?.height else{
            return
        }
        
        guard let weight = poke_data?.weight else{
            return
        }
        
        guard let types = poke_data?.types else {
            return
        }
        
        for type in types {

            if type.type.name == types.last!.type.name{
                type_string += type.type.name
                continue
            }
            
            type_string += type.type.name + ", "
        }
        
        let text = "The pokemon \(name) is of type \(type_string).  The average height of \(name) is \(height) with a average weight \(weight)."
        self.discriptionLabel.text = text
    }
    
    private func pokemon_moves(){
        var text = "\nMoves: \n\n"
        guard let moves = poke_data?.moves else{
            return
        }
        
        for i in 0..<moves.count {
            if i%3 == 0 && i != 0{
                text += moves[i].move.name + ",\n"
                continue
            }
            
            if i == moves.count - 1 {
                text += moves[i].move.name
                continue
            }
            
            text += moves[i].move.name + ", "
        }
        
        self.moves_poke.text = text
    }
    
    private func pokemon_abilities(){
        var text = "\nAbilities: \n\n"
        guard let ability = poke_data?.abilities else{
            return
        }
        
        for i in 0 ..< ability.count {
            if i%3 == 0 && i != 0 {
                text += ability[i].ability.name + ",\n"
                continue
            }
            
            if i == ability.count - 1 {
                text += ability[i].ability.name
                continue
            }
            
            text += ability[i].ability.name + ", "
        }
        
        self.abilities_poke.text = text
    }
    

}
