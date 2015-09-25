//
//  BinarySearchTreeTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class BinarySearchTreeTests: XCTestCase {

	let testTree = BinarySearchTree<Int, Int>()
	
	override func setUp() {
		super.setUp()
		
		testTree.insert(18, value: 18)
		testTree.insert(12, value: 12)
		testTree.insert(25, value: 25)
		testTree.insert(4, value: 4)
		testTree.insert(15, value: 15)
		testTree.insert(25, value: 25)
		testTree.insert(30, value: 30)
		testTree.insert(1, value: 1)
		testTree.insert(13, value: 13)
		testTree.insert(17, value: 17)
		testTree.insert(28, value: 28)
		testTree.insert(3, value: 3)
		testTree.insert(14, value: 14)
		testTree.insert(29, value: 29)
	}
	
	func testSetUp() {
		XCTAssertEqual(testTree.structureDescription, "(((1 \\(3))/ 4)/ 12 \\((13 \\(14))/ 15 \\(17)))/ 18 \\(25 \\(25 \\((28 \\(29))/ 30)))")
	}
	
	func testRandom() {
		
		testTree.insert(2, value: 2)
		print(testTree)
		XCTAssertEqual(testTree.structureDescription, "(((1 \\((2)/ 3))/ 4)/ 12 \\((13 \\(14))/ 15 \\(17)))/ 18 \\(25 \\(25 \\((28 \\(29))/ 30)))")
		testTree.delete(30)
		print(testTree)
		XCTAssertEqual(testTree.structureDescription, "(((1 \\((2)/ 3))/ 4)/ 12 \\((13 \\(14))/ 15 \\(17)))/ 18 \\(25 \\(25 \\(28 \\(29))))")
		testTree.delete(12)
		print(testTree)
		XCTAssertEqual(testTree.structureDescription, "(((1 \\((2)/ 3))/ 4)/ 13 \\((14)/ 15 \\(17)))/ 18 \\(25 \\(25 \\(28 \\(29))))")
	}

}
