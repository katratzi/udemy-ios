//
//  CoinData.swift
//  ByteCoin
//
//  Created by Richard Clifford on 21/02/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    
    let asset_id_quote : String
    let rate: Double
}
