//
//  Graph.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/28/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

// Any graph, whether directed or undirected, weighted or unweighted, all in this single class.

/// Graph data structure
public class Graph<KeyT: Hashable, WeightT: Numeric> : CustomStringConvertible {
	
	var directed: Bool = true
	var weighted: Bool = false
	
	private var vertices = [KeyT: Vertex<KeyT>]()
	
	var defaultWeight: WeightT?
	
	/// Directed, unweighted empty graph
	public init() {
		
	}
	
	/// Unweighted graph
	public init(directed: Bool) {
		self.directed = directed
	}
	
	/// Weighted graph with a default weight
	public init(directed: Bool, defaultWeight: WeightT) {
		self.directed = directed
		weighted = true
		self.defaultWeight = defaultWeight
	}
	
	public func hasVertex(key: KeyT) -> Bool {
		return vertices[key] != nil
	}
	
	public func addVertex(key: KeyT) {
		
		let v = Vertex(key: key)
		if vertices[key] == nil {
			vertices[key] = v
		} else {
			fatalError("Vertex with the same key already exist.")
		}
	}
	
	public func removeVertex(key: KeyT) {
		
		// return if vertex don't exist
		guard let v = vertices[key] else {
			return
		}
		
		// remove edges lead to this vertex
		for (_, vertex) in vertices {
			vertex.removeEdgeTo(vertex: v)
		}
	}
	
	public func hasEdge(from from: KeyT, to: KeyT) -> Bool {
		guard let u = vertices[from] else {
			return false
		}
		guard let v = vertices[to] else {
			return false
		}
		
		return u.hasEdge(v)
	}
	
	public func addEdge(from from: KeyT, to: KeyT) {
		
		guard let u = vertices[from] else {
			return
		}
		guard let v = vertices[to] else {
			return
		}
		
		if !weighted {
			
			u.addEdge(Edge(from: u, to: v))
			
			if !directed {
				v.addEdge(Edge(from: v, to: u))
			}
		} else {
			
			u.addEdge(WeightedEdge(from: u, to: v, weight: defaultWeight!))
			
			if !directed {
				v.addEdge(WeightedEdge(from: v, to: u, weight: defaultWeight!))
			}
		}
	}
	
	public func addEdge(from from: KeyT, to: KeyT, weight: WeightT) {
		
		if !weighted {	// if graph unweighted, ignore weight
			addEdge(from: from, to: to)
		} else {
			
			guard let u = vertices[from] else {
				return
			}
			guard let v = vertices[to] else {
				return
			}
			u.addEdge(WeightedEdge(from: u, to: v, weight: weight))
			
			if !directed {
				v.addEdge(WeightedEdge(from: v, to: u, weight: weight))
			}
		}
	}
	
	public func removeEdge(from from: KeyT, to: KeyT) {
		
		guard let u = vertices[from] else {
			return
		}
		guard let v = vertices[to] else {
			return
		}
		u.removeEdgeTo(vertex: v)
		
		if !directed {
			v.removeEdgeTo(vertex: u)
		}
	}
	
	public func neighbors(key: KeyT) -> [KeyT]? {
		guard let u = vertices[key] else {
			return nil
		}
		return u.neighbors().map({$0.key})
	}
	
	public func dfs(from from: KeyT, to: KeyT) -> [KeyT]? {
		
		guard let s = vertices[from] else {
			return nil
		}
		
		resetVisited()
		
		let stack = Stack<Vertex<KeyT>>()
		
		stack.push(s)
		while !stack.isEmpty {
			
			let u = stack.top()!
			if u.visited {
				
				// post visit u here
				print("post: \(u.key)")
				
				stack.pop()
			} else {
				
				u.visited = true
				// pre visit u
				print("pre: \(u.key)")
				
				for e in u.adj {
					
					let v = e.to
					if !v.visited {
						
						stack.push(v)
					}
				}
			}
		}
		
		return nil
	}
	
	// return a dictionary with vertex name as key and distance as value
	public func dijkstra(key: KeyT) -> [KeyT: WeightT]? {
		
		if !weighted {
			fatalError("Dijkstra's algorithm can only be implemented on weighted graph.")
		}
		
		guard let s = vertices[key] else {
			return nil
		}
		
		// initalize
		var distance = [KeyT: WeightT]()
		for (key, v) in vertices {
			v.visited = false	// reset `visited`s to false
			distance[key] = WeightT.infinity()
		}
		distance[s.key] = WeightT.zero()
		
		var currentV: Vertex<KeyT> = s
		var nextV: Vertex<KeyT>? = s
		
		while nextV != nil {
			
			currentV = nextV!
			currentV.visited = true
			nextV = nil	// keep track of closest vertexs
			
			for e in currentV.adj {
				
				// throw error if negative weight is found
				let weight = (e as! WeightedEdge<KeyT, WeightT>).weight
				if weight < WeightT.zero() {
					fatalError("Dijkstra's algorithm can only be implemented on graph with non-negative weight.")
				}
				
				let newDistance = distance[currentV.key]! + weight
				
				// update distance if smaller than former value
				if newDistance < distance[e.to.key]! {
					distance[e.to.key] = newDistance
				}
				
				if !e.to.visited {
					// update next vertex to be the closest, yet visited vertex
					if nextV == nil || newDistance < distance[nextV!.key]! {
						nextV = e.to
					}
				}
			}
		}
		
		
		return distance
	}
	
	public func bellmanFord(key: KeyT) -> [KeyT: WeightT]? {
		
		if !weighted {
			fatalError("Bellman-Ford algorithm can only be implemented on weighted graph.")
		}
		
		guard let s = vertices[key] else {	// starting vertex
			return nil
		}
		
		var distance = [KeyT : WeightT]()
		
		//		var predecessor = [KeyT: KeyT?]()
		
		// initalize graph
		var vertexCount = 0
		for (_, v) in vertices {
			
			if (v === s) {
				distance[v.key] = WeightT.zero()
			} else {
				distance[v.key] = WeightT.infinity()
			}
			//			predecessor[v.key] = nil
			vertexCount++
		}
		
		// relax edges repeatedly
		for _ in 1..<vertexCount {	// repeat |V| - 1 times
			
			// go through all edges
			for (_, u) in vertices {
				for e in u.adj {
					
					let v = e.to
					let weight = (e as! WeightedEdge<KeyT, WeightT>).weight
					let distU = distance[u.key]!	// temp distance to u
					let distV = distance[v.key]!	// temp distance to v
					
					if distU != WeightT.infinity() {
						
						let newDist = distU + (e as! WeightedEdge<KeyT, WeightT>).weight
						
						// update distance if a shorter path is found
						if newDist < distV {
							distance[v.key] = distU + weight
							//							predecessor[v.key] = u.key
						}
					}
				}
			}
		}
		
		// check for negative-weight cycles
		// go through all edges
		for (_, u) in vertices {
			for e in u.adj {
				
				let v = e.to
				let weight = (e as! WeightedEdge<KeyT, WeightT>).weight
				let distU = distance[u.key]!	// final distance to u
				let distV = distance[v.key]!	// final distance to v
				if distU + weight < distV {
					fatalError("negative-weight cycles exists")
				}
			}
		}
		
		return distance
	}
	
	private func vertexArray() -> [Vertex<KeyT>] {
		
		var vArray = [Vertex<KeyT>]()
		for (_, v) in vertices {
			vArray.append(v)
		}
		return vArray
	}
	
	public func vertexKeyArray() -> [KeyT] {
		
		var kArray = [KeyT]()
		for (k, _) in vertices {
			kArray.append(k)
		}
		return kArray
	}
	
	private func resetVisited() {
		for (_, v) in vertices {
			v.visited = false
		}
	}
	
	
	public var description: String {
		
		var desc = ""
		for (key, u) in vertices {
			desc += "\(key)"
			desc += " -> ["
			
			for e in u.adj {
				if weighted {
					let weight = (e as! WeightedEdge<KeyT, WeightT>).weight
					desc += "(\(weight))"
				}
				desc += "\(e.to.key)"
				desc += ", "
			}
			
			if !u.adj.isEmpty {
				// remove last seperator ", "
				desc.removeAtIndex(desc.endIndex.predecessor())
				desc.removeAtIndex(desc.endIndex.predecessor())
			}

			desc += "]\n"
		}
		
		return desc
	}
}

private class Vertex<KeyT>: CustomStringConvertible {
	
	/// name of the vertex
	var key: KeyT
	var adj = [Edge<KeyT>]()	// adjacency list
	
	var visited: Bool = false	// use in BFS and DFS
	
	private init(key: KeyT) {
		self.key = key
	}
	
	private func hasEdge(to: Vertex<KeyT>) -> Bool {
		for e in adj {
			if e.to === to {
				return true
			}
		}
		return false
	}
	
	private func addEdge(edge: Edge<KeyT>) {
		adj.append(edge)
	}
	
	// remove all edges lead to `v` in adjacency list
	private func removeEdgeTo(vertex v: Vertex<KeyT>) {
		
		for var i = 0; i < adj.count; i++ {
			if adj[i].to === v {
				// remove the edge
				adj.removeAtIndex(i)
				i--
			}
		}
	}
	
	private func neighbors() -> [Vertex<KeyT>] {
		var neighbors = [Vertex<KeyT>]()
		for e in adj {
			neighbors.append(e.to)
		}
		return neighbors
	}
	
	private var description: String {
		return "\(key)"
	}
}

private class Edge<KeyT>: CustomStringConvertible {
	
	var from: Vertex<KeyT>
	var to: Vertex<KeyT>
	
	private init(from: Vertex<KeyT>, to: Vertex<KeyT>) {
		self.from = from
		self.to = to
	}
	
	private var description: String {
		return "\(from) --> \(to)"
	}
}

private class WeightedEdge<KeyT, WeightT> : Edge<KeyT> {
	
	var weight: WeightT
	
	private init(from: Vertex<KeyT>, to: Vertex<KeyT>, weight: WeightT) {
		
		self.weight = weight
		super.init(from: from, to: to)
	}
	
	private override var description: String {
		return "\(from) -(\(weight))-> \(to)"
	}
}

public protocol Numeric: Comparable {
	func +(lhs: Self, rhs: Self) -> Self
	
	///	returns additive identity of this type
	///
	///	- returns: additive identity
	static func zero() -> Self
	
	static func infinity() -> Self
}

extension Int: Numeric {
	public static func zero() -> Int {
		return 0
	}
	public static func infinity() -> Int {
		return Int.max
	}
}

extension UInt: Numeric {
	public static func zero() -> UInt {
		return 0
	}
	public static func infinity() -> UInt {
		return UInt.max
	}
}

extension Float: Numeric {
	public static func zero() -> Float {
		return 0
	}
	public static func infinity() -> Float {
		return Float.infinity
	}
}

extension Double: Numeric {
	public static func zero() -> Double {
		return 0
	}
	public static func infinity() -> Double {
		return Double.infinity
	}
}
