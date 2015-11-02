//
//  DirectedGraphTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/29/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class DirectedGraphTests: XCTestCase {

	let g = Graph<String, Int>()
	
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
		
		// directed graph don't create around-about edge
		XCTAssertFalse(g.hasEdge(from: "B", to: "A"))
		XCTAssertFalse(g.hasEdge(from: "C", to: "B"))
		XCTAssertFalse(g.hasEdge(from: "D", to: "B"))
		XCTAssertFalse(g.hasEdge(from: "C", to: "D"))
		XCTAssertFalse(g.hasEdge(from: "E", to: "C"))
		XCTAssertFalse(g.hasEdge(from: "D", to: "E"))
		
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
		print(g.neighbors("A"))
		print(g.neighbors("B"))
		print(g.neighbors("C"))
		print(g.neighbors("D"))
		print(g.neighbors("E"))
		
		XCTAssertNil(g.neighbors("Z"))
	}
	
	func testVertexKeyArray() {
		
		print("-----\(__FUNCTION__)-----")
		print(g.vertexKeyArray())
	}

}
