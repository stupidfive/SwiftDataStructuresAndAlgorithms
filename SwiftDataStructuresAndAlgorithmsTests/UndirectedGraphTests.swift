//
//  UndirectedGraphTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/29/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class UndirectedGraphTests: XCTestCase {

	let g = Graph<String, Int>(directed: false)
	
	override func setUp() {
		super.setUp()
		
		g.addVertex("A")
		g.addVertex("B")
		g.addVertex("C")
		g.addVertex("D")
		g.addVertex("E")
		
		g.addEdge(from: "A", to: "B")
		g.addEdge(from: "B", to: "C")
		g.addEdge(from: "B", to: "D")
		g.addEdge(from: "D", to: "C")
		g.addEdge(from: "C", to: "E")
		g.addEdge(from: "E", to: "D")
	}
	
	func testPrint() {
		print("-----\(__FUNCTION__)-----")
		print(g)
	}
	
	func testVertices() {
		XCTAssert(g.hasVertex("A"))
		XCTAssert(g.hasVertex("B"))
		XCTAssert(g.hasVertex("C"))
		XCTAssert(g.hasVertex("D"))
		XCTAssert(g.hasVertex("E"))
		
		XCTAssertFalse(g.hasVertex("Z"))
	}
	
	func testEdges() {
		// edges added
		XCTAssert(g.hasEdge(from: "A", to: "B"))
		XCTAssert(g.hasEdge(from: "B", to: "C"))
		XCTAssert(g.hasEdge(from: "B", to: "D"))
		XCTAssert(g.hasEdge(from: "D", to: "C"))
		XCTAssert(g.hasEdge(from: "C", to: "E"))
		XCTAssert(g.hasEdge(from: "E", to: "D"))
		
		// directed graph creates around-about edge
		XCTAssert(g.hasEdge(from: "B", to: "A"))
		XCTAssert(g.hasEdge(from: "C", to: "B"))
		XCTAssert(g.hasEdge(from: "D", to: "B"))
		XCTAssert(g.hasEdge(from: "C", to: "D"))
		XCTAssert(g.hasEdge(from: "E", to: "C"))
		XCTAssert(g.hasEdge(from: "D", to: "E"))
		
		// edges didn't create
		XCTAssertFalse(g.hasEdge(from: "A", to: "E"))
		XCTAssertFalse(g.hasEdge(from: "A", to: "C"))
		XCTAssertFalse(g.hasEdge(from: "A", to: "D"))
		XCTAssertFalse(g.hasEdge(from: "B", to: "E"))
		
		// remove all edges
		g.removeEdge(from: "A", to: "B")
		g.removeEdge(from: "B", to: "C")
		g.removeEdge(from: "B", to: "D")
		g.removeEdge(from: "D", to: "C")
		g.removeEdge(from: "C", to: "E")
		g.removeEdge(from: "E", to: "D")
		
		XCTAssertFalse(g.hasEdge(from: "A", to: "B"))
		XCTAssertFalse(g.hasEdge(from: "B", to: "C"))
		XCTAssertFalse(g.hasEdge(from: "B", to: "D"))
		XCTAssertFalse(g.hasEdge(from: "D", to: "C"))
		XCTAssertFalse(g.hasEdge(from: "C", to: "E"))
		XCTAssertFalse(g.hasEdge(from: "E", to: "D"))
		
		XCTAssertFalse(g.hasEdge(from: "B", to: "A"))
		XCTAssertFalse(g.hasEdge(from: "C", to: "B"))
		XCTAssertFalse(g.hasEdge(from: "D", to: "B"))
		XCTAssertFalse(g.hasEdge(from: "C", to: "D"))
		XCTAssertFalse(g.hasEdge(from: "E", to: "C"))
		XCTAssertFalse(g.hasEdge(from: "D", to: "E"))
	}
	
	func testVertexNeighbors() {
		print("-----\(__FUNCTION__)-----")
		print("A: " + g.neighbors("A")!.description)
		print("B: " + g.neighbors("B")!.description)
		print("C: " + g.neighbors("C")!.description)
		print("D: " + g.neighbors("D")!.description)
		print("E: " + g.neighbors("E")!.description)
		
		XCTAssertNil(g.neighbors("Z"))
	}


}
