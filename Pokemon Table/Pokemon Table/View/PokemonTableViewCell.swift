//
//  PokemonTableViewCell.swift
//  Pokemon Table
//
//  Created by Consultant on 5/5/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let reuseId = "\(PokemonTableViewCell.self)"
    
    let pokemonImageView:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.contentMode = .scaleAspectFit
        //img.layer.cornerRadius = 35
        img.image = UIImage(named: "question-mark") //Took from you as image holder
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOpacity = 1
        img.layer.shadowOffset = .zero
        img.layer.shadowRadius = 10
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokemon name"
        label.font = UIFont(name:"Courier", size: 20.0)
        label.textColor = .black
        return label
    }()
    
    let typeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Types: "
        label.textColor = .black
        label.font = UIFont(name:"Courier", size: 15.0)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    
    var net_manager = NetworkManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        SetupCell()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupCell(){
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.pokemonImageView)
        
        let vStackLeft = UIStackView(frame: .zero)
        vStackLeft.translatesAutoresizingMaskIntoConstraints = false
        vStackLeft.axis = .vertical
        vStackLeft.spacing = 8
        
        let topBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)
        let bottomBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)
        
        vStackLeft.addArrangedSubview(topBuffer)
        vStackLeft.addArrangedSubview(self.pokemonImageView)
        vStackLeft.addArrangedSubview(bottomBuffer)
        
        let vStackRight = UIStackView(frame: .zero)
        vStackRight.translatesAutoresizingMaskIntoConstraints = false
        vStackRight.axis = .vertical
        vStackRight.spacing = 8
        vStackRight.distribution = .fillProportionally
        
        vStackRight.addArrangedSubview(self.nameLabel)
        vStackRight.addArrangedSubview(self.typeLabel)
        
        let hStack = UIStackView(frame: .zero)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.spacing = 20
        
        hStack.addArrangedSubview(vStackLeft)
        hStack.addArrangedSubview(vStackRight)
        
        self.contentView.addSubview(hStack)
        
        hStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        hStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        hStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        hStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
        self.pokemonImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.pokemonImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        topBuffer.heightAnchor.constraint(equalTo: bottomBuffer.heightAnchor).isActive = true
        
    }
    
    func configure(poke_link: Basic_Data, completion: @escaping (PokemonModel) -> Void){
        reset()
        var title = ""
        self.nameLabel.text = poke_link.name
        self.net_manager.pokemon_attributes(url_string: poke_link.url){[weak self] result in
            switch result {
            case .success(let poke):
                for type in poke.types {
                    title += type.type.name + " "
                }
                
                guard let pic_link = poke.sprites.front_default else {
                    return
                }

                self?.net_manager.pokemon_image(url_string: pic_link){ [weak self]
                    result in
                    
                    switch result {
                    case .success(let pic):
                        ImageCache.shared.setImageData(key: pic_link, data: pic)
                        DispatchQueue.main.async {
                            self?.pokemonImageView.image = UIImage(data: pic)
                            self?.typeLabel.text! += " " + title
                        }
                        completion(poke)
                    case .failure(let err):
                        print(err)
                    }
                    
                }
                
            case .failure(let err):
                print(err)
            }
        }
        
    }
    
    private func reset() {
        self.pokemonImageView.image = UIImage(named: "question-mark")
        self.nameLabel.text = "Pokemon Name"
        self.typeLabel.text = "Type:"
    }

}
