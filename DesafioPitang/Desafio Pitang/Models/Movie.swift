//
//  Movie.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let name: String
    let url: URL
    let _id: String
    let description: String
}
