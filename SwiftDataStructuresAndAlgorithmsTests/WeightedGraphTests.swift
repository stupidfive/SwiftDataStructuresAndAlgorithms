//
//  WeightedGraphTests.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/29/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import XCTest
@testable import SwiftDataStructuresAndAlgorithms

class WeightedGraphTests: XCTestCase {

	let g = Graph<String, Double>(directed: true, defaultWeight: 1.0)
	
	override func setUp() {
		super.setUp()
		
		g.addVertex("A")
		g.addVertex("B")
		g.addVertex("C")
		g.addVertex("D")
		g.addVertex("E")
		g.addVertex("F")
		
		g.addEdge(from: "A", to: "E", weight: 0.1)
		g.addEdge(from: "A", to: "F", weight: 0.9)
		g.addEdge(from: "B", to: "A", weight: 0.3)
		g.addEdge(from: "B", to: "C", weight: 0.3)
		g.addEdge(from: "B", to: "D", weight: 0.4)
		g.addEdge(from: "C", to: "D", weight: 0.6)
		g.addEdge(from: "C", to: "E", weight: 0.4)
		g.addEdge(from: "D", to: "E")
		g.addEdge(from: "E", to: "F", weight: 0.45)
		g.addEdge(from: "E", to: "A", weight: 0.55)
		g.addEdge(from: "F", to: "D")
	}
	
	func testPrint() {
		print(g)
	}
	
	func testDFS() {
		g.dfs(from: "A", to: "A")
	}
	
	func testBellmanFord() {
		print("-----\(__FUNCTION__)-----")
		print(g.bellmanFord("A"))
		print(g.bellmanFord("B"))
		print(g.bellmanFord("C"))
		print(g.bellmanFord("D"))
		print(g.bellmanFord("E"))
		print(g.bellmanFord("F"))
	}
	
	func testDijkstra() {
		print("-----\(__FUNCTION__)-----")
		print(g.dijkstra("A"))
		print(g.dijkstra("B"))
		print(g.dijkstra("C"))
		print(g.dijkstra("D"))
		print(g.dijkstra("E"))
		print(g.dijkstra("F"))
	}

}
