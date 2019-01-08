//
//  PercentEncoding.swift
//  RxSwiftStudy
//
//  Created by share2glory on 2019/1/8.
//  Copyright © 2019 WH. All rights reserved.
//

import Foundation
import JavaScriptCore

public enum PercentEncoding {
    case EncodeURI, EncodeURIComponent, DecodeURI, DecodeURIComponent
    
    /// return equivalent javascript function name
    private var functionName: String {
        switch self {
        case .EncodeURI:            return "encodeURI"
        case .EncodeURIComponent:   return "encodeURIComponent"
        case .DecodeURI:            return "decodeURI"
        case .DecodeURIComponent:   return "decodeURIComponent"
        }
    }
    
    public func evaluate(string: String) -> String {
        // escape single quote becasue it is used in script string
        let escaped = string.replacingOccurrences(of: "'", with: "\\'")
        let script = "var value = \(functionName)('\(escaped)');"
        let context = JSContext()
        context?.evaluateScript(script)
        let value: JSValue = context!.objectForKeyedSubscript("value")
        return value.toString()
    }
}
