//
//  SplayTreeTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/26/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class SplayTreeTests: XCTestCase {

	func testRandom() {
		
		let splTree = SplayTree<Int, String>()
		
		let array: Array<Int>
		array = [8, 3, 8, 7, 1, 4, 6]
		var i = 0
		for n in array {
			print("insert[\(i)]: \t\(n)")
			
			splTree.insert(n, value: "#\(i)")
			i++
			print("result: \t\(splTree)")
			print("invari: \t\(splTree.invarianceParentChildRelation(splTree.root))")
			print("-------")
		}
		
		splTree.find(72)
		splTree.insert(32, value: "")
		splTree.delete(72)
		
		print("invari: \t\(splTree.invarianceParentChildRelation(splTree.root))")
		print("final: \t\(splTree)")
	}

}
