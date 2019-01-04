//
//  Dependency.swift
//  MurrayTests
//
//  Created by Stefano Mondino on 03/01/2019.
//

import Foundation
import MurrayKit
import Files
class TestDependency: Dependency {
    let skeletonSpec = """
    {
        "scripts": [""],
        "foldersToRename" : ["SkeletonTestFolder", "Skeleton.xcodeproj"],
        "filesToRename" : ["SkeletonTestFolder/SkeletonTestFile1.txt","SkeletonTestFolder/SkeletonTestFile2.txt"],
        "filePlaceholder": "Skeleton"
    }
"""
    func cloneProject(from git:URL) throws {
        let fs = FileSystem()
        try fs.createFolderIfNeeded(at: "Tests").delete()
        let main = try fs.createFolderIfNeeded(at: "Tests")
        try main.createSubfolder(named: ".git")
        let skeletonTestFolder = try main.createSubfolder(named: "SkeletonTestFolder")
        try main.createSubfolder(named: "UntouchedTestFolder")
        try main.createSubfolder(named: "Skeleton.xcodeproj")
        try skeletonTestFolder.createFile(named: "SkeletonTestFile1.txt")
        try skeletonTestFolder.createFile(named: "SkeletonTestFile2.txt")
        try skeletonTestFolder.createFile(named: "UntouchedTestFile1.txt")
        try main.createFile(named: "Skeletonspec.json", contents: skeletonSpec)
        print (main.path)
        print ("faking git clone from \(git)")
    }
}