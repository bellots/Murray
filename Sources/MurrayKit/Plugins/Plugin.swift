//
//  Plugin.swift
//  MurrayKit
//
//  Created by Stefano Mondino on 23/02/2019.
//

import Foundation
import Files

open class Plugin {
    public init() {
        
    }
    open func finalize(bone: Bone) {
        
    }
    open class func getInstance() -> Plugin {
        return Plugin()
    }
}
extension Plugin {
    static func all() throws -> [Plugin] {
        let path = "~/.murray/Plugins"
        guard let folder = try? Folder(path: path) else {
            throw Error.pluginNotFound
        }
        
        return folder.subfolders
            .filter { $0.extension == "bundle" }
            .compactMap { Bundle(path: $0.path)?.executablePath }
            .compactMap { LoadPlugin(onto: Plugin.self, dylib: $0 ).getInstance()}
        
    }
}
func LoadPlugin<T:Plugin>(onto: T.Type, dylib: String) -> T.Type {
    guard let handle = dlopen(dylib, RTLD_NOW) else {
        fatalError("Could not open \(dylib) \(String(cString: dlerror()))")
    }
    
    guard let principalClass = dlsym(handle, "principalClass") else {
        fatalError("Could not locate principalClass function")
    }
    
    let replacement = unsafeBitCast(principalClass,
                                    to: (@convention (c) () -> UnsafeRawPointer).self)
    return unsafeBitCast(replacement(), to: T.Type.self)
}


public extension Plugin {
    enum Error: String, Swift.Error, CustomStringConvertible {
        public var description: String {
            return rawValue
        }
        
        case pluginNotFound
    }
}
