//
//  MStations.swift
//  PictureCollectionView
//
//  Created by Matvei  on 01.12.2020.
//

import Foundation


struct ServerJSON: Decodable{
    var lines: [MLines]
}

struct MLines: Decodable{
    var name: String
    var hex_color: String
    var stations: [MStations]
}

struct MStations: Decodable{
    var name: String
    var id: String
}
