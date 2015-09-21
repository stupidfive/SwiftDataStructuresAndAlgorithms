//
//  QueueTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 9/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class QueueTests: XCTestCase {

	func testDequeueEmpty() {
		let queue = Queue<Int>()
		queue.dequeue()
		XCTAssert(queue.isEmpty)
		XCTAssert(queue.dequeue() == nil)
	}
	
	func testRandom() {
		
		let queue = Queue<Int>()
		var item: Int? = 0
		
		queue.enqueue(0)
		item = queue.dequeue()
		XCTAssertEqual(item, 0)
		item = queue.dequeue()
		XCTAssertEqual(item, nil)
		queue.enqueue(1)
		queue.enqueue(2)
		queue.enqueue(3)
		queue.enqueue(4)
		item = queue.dequeue()
		XCTAssertEqual(item, 1)
		queue.enqueue(5)
		queue.enqueue(6)
		queue.enqueue(7)
		item = queue.dequeue()
		XCTAssertEqual(item, 2)
		queue.enqueue(8)
		queue.enqueue(9)
		
		print(queue)
		XCTAssertEqual(queue.description, "[3, 4, 5, 6, 7, 8, 9]")
		
		for _ in 0..<10 {
			queue.dequeue()
		}
		XCTAssertEqual(queue.description, "[]")
	}

}
