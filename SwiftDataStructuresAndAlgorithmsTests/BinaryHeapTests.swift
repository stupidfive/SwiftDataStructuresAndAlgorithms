//
//  BinaryHeapTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/26/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class BinaryHeapTests: XCTestCase {

	let heap = BinaryHeap<Int, Int>()
	
	override func setUp() {
		super.setUp()
		
		heap.insert(2, value: 2)
		heap.insert(5, value: 5)
		heap.insert(3, value: 3)
		heap.insert(9, value: 9)
		heap.insert(6, value: 6)
		heap.insert(11, value: 11)
		heap.insert(4, value: 4)
		heap.insert(17, value: 17)
		heap.insert(10, value: 10)
		heap.insert(8, value: 8)
	}
	
	func testInsertion() {
		
		heap.insert(2, value: 2)
		XCTAssertEqual(heap.description, "[nil, 2, 2, 3, 9, 5, 11, 4, 17, 10, 8, 6]")
	}
	
	func testDeleteMin() {
		
		heap.deleteMin()
		XCTAssertEqual(heap.description, "[nil, 3, 5, 4, 9, 6, 11, 8, 17, 10]")
	}

}
