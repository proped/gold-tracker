//
//  FileManagerError.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation

enum FileManagerError : Error {
    
    case fileNotExist
    case invalidFileFormat
    case saveFileFailed(error: Error)
    case loadFileFailed(error: Error)
    case removeFileFailed(error: Error)
}

