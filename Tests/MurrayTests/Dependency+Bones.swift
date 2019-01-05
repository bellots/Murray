//
//  Dependency+Bones.swift
//  MurrayKit
//
//  Created by Stefano Mondino on 04/01/2019.
//

import Foundation
import Files

extension TestDependency {
    func bonespec(named name: String) -> String {
        return """
    {
        "version": "0.2",
        "sourcesBaseFolder": "Files",
        "destinationBaseFolder": "",
        "name": "\(name)",
        "bones": [
        {
        "name": "test",
        "description": "A test",
        "folderPath": "Sources",
        "createSubfolder": false,
        "targets" : ["Test"],
        "files": ["Bone.swift"]
        }]
        }
"""
    }

    var boneTemplate: String {
        return "Some template with a {{ name }} placeholder, also uppercased {{ name|uppercase }}"
    }
    func templateResolved(with name: String) -> String {
        return boneTemplate
            .replacingOccurrences(of: "{{ name }}", with: name)
            .replacingOccurrences(of: "{{ name|uppercase }}", with: name.uppercased())
    }
//    func boneSpecTest() throws {
//        try boneSpecTest(named: "testA")
//        try boneSpecTest(named: "testB")
//    }
    func boneSpecTest(named name: String) throws {
        let fs = FileSystem()
        let bones = try fs.currentFolder.createSubfolder(named: name)
        try bones.createFile(named: "Bonespec.json", contents: bonespec(named: name))
        let files = try bones.createSubfolder(named: "Files")
        try files.createFile(named: "Bone.swift", contents: boneTemplate)
    }
}
