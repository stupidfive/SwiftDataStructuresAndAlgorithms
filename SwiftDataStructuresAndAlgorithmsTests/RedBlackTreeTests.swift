//
//  RedBlackTreeTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/29/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class RedBlackTreeTests: XCTestCase {

	func test() {
		
		let rbt = RedBlackTree<Int, String>()
		
		let array: Array<Int>
		array = [42,82,72,41,69,9,80,56,16,19]
		var i = 0
		for n in array {
			print("insert[\(i)]: \t\(n)")
			
			rbt.insert(n, value: "#\(i)")
			i++
			print("result: \t\(rbt)")
			print("invari: \t\(rbt.invarianceParentChildRelation(rbt.root))")
			print("-------")
		}
		
		print("invari: \t\(rbt.invarianceParentChildRelation(rbt.root))")
		print("final: \t\(rbt)")
	}
	
}
