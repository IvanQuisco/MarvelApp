//
//  String+Ext.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 12/02/22.
//

import CryptoKit

extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
