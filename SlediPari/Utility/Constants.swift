//
//  Constants.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import Foundation

let USE_LOCALHOST = true
let BASE_URL = "https://desolate-chamber-91023.herokuapp.com/"
let BASE_URL_LOCALHOST = "http://192.168.0.105:1926/"

func getBaseUrl() -> String {
    
    return USE_LOCALHOST ? BASE_URL_LOCALHOST : BASE_URL
}
