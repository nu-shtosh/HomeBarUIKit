//
//  Developer.swift
//  HomeBar
//
//  Created by Armen Madoyan on 30.10.2022.
//

struct Developer {
    let name: String
    let surname: String
    let photo: String
    let info: String
    
    var fullname: String {
        "\(surname) \(name)"
    }
    
    static func getDeveloperList() -> [Developer] {
        var developers: [Developer] = []
        
        let names = DevelopersDataStore.shared.names
        let surnames = DevelopersDataStore.shared.surnames
        let photos = DevelopersDataStore.shared.photos
        let infos = DevelopersDataStore.shared.infos
        
        let iteration = min(names.count, surnames.count, photos.count, infos.count)
        
        for index in 0..<iteration {
            let developer = Developer(
                name: names[index],
                surname: surnames[index],
                photo: photos[index],
                info: infos[index]
            )
            developers.append(developer)
        }
        
        return developers.sorted { $0.surname < $1.surname }
    }
}

