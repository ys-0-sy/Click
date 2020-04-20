//
//  APIServiceError.swift
//  Clip
//
//  Created by saito on 2020/04/20.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
  case invalidURL
  case responseError
  case parseError(Error)
}
