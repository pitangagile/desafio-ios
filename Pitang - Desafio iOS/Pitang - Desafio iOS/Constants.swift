//
//  Constants.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import Foundation

//MARK: - URLs
let URL_listMovies = "https://desafio-mobile-pitang.herokuapp.com/movies/list?page=%d&size=%d"
let URL_detailMovie = "https://desafio-mobile-pitang.herokuapp.com/movies/detail/%@"

//MARK: - Notification objects
let NOTIFICATION_receivedListMovies = Notification.Name(rawValue: "receivedListMovies")
let NOTIFICATION_receivedDetailMovie = Notification.Name(rawValue: "receivedDetailMovie")
