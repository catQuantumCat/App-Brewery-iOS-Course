//
//  ConditionConstant.swift
//  Clima
//
//  Created by Huy on 18/9/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

enum WeatherConditionEnum : String{
    case Thunderstorm = "cloud.bolt.fill"
    case Drizzle = "cloud.drizzle.fill"
    case Rain = "cloud.rain.fill"
    case Snow = "cloud.snow.fill"
    case Atmosphere = "cloud.fog.fill"
    case Clear = "sun.max.fill"
    case Clouds = "cloud.fill"
    case Error = "exclamationmark.octagon.fill"
}
