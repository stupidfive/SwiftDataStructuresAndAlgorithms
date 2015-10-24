//
//  SHA1.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/21/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation
public func sha1String(string string: String) -> String {
	let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
	return sha1String(data: data)
}

public func sha1String(data data: NSData) -> String {
	let sha1Data = sha1(data: data)
	var md = [UInt32](count: 5, repeatedValue: 0)
	var mdString = ""
	for i in 0..<5 {
		sha1Data.getBytes(&md[i], range: NSRange(location: 4 * i, length: 4))
		mdString.appendContentsOf(String(format: "%08x", md[i]))
	}
	
	return mdString
}

public func sha1(string string: String) -> NSData {
	let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
	return sha1(data: data)
}

public func sha1(data data: NSData) -> NSData {
	
	// https://tools.ietf.org/html/rfc3174
	
	let data = data.mutableCopy() as! NSMutableData
	
	let length: UInt64 = UInt64(data.length)
	let paddingLength = (56 + 64 - data.length % 64) % 64
	
	// pad up to 56 mod 64
	var one: UInt8 = 0x80	// 1000 ...
	var zero: UInt8 = 0x00	// 0000 ...
	data.appendBytes(&one, length: 1)
	for _ in 0..<paddingLength - 1 {
		data.appendBytes(&zero, length: 1)
	}
	
	// append length (reversed)
	var lengthInBits: UInt64 = length * 8
	let lengthData = NSData(bytes: &lengthInBits, length: 8)
	data.appendData(lengthData.subdataWithRange(NSRange(location: 7, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 6, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 5, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 4, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 3, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 2, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 1, length: 1)))
	data.appendData(lengthData.subdataWithRange(NSRange(location: 0, length: 1)))
	
	// initalize h
	var h0: UInt32 = 0x67452301
	var h1: UInt32 = 0xefcdab89
	var h2: UInt32 = 0x98badcfe
	var h3: UInt32 = 0x10325476
	var h4: UInt32 = 0xc3d2e1f0
	
	for var i = 0; i < data.length / 64; i++ {
		
		var w = [UInt32](count: 80, repeatedValue: 0)
		
		// a. Divide M(i) into 16 words W(0), W(1), ... , W(15),
		//    where W(0) is the left-most word.
		for var t = 0; t < 16; t++ {
			
			var tempByte: UInt32 = 0;
			data.getBytes(&tempByte, range: NSRange(location: i * 64 + t * 4 + 3, length: 1))
			w[t] |= tempByte
			data.getBytes(&tempByte, range: NSRange(location: i * 64 + t * 4 + 2, length: 1))
			w[t] |= tempByte << 8
			data.getBytes(&tempByte, range: NSRange(location: i * 64 + t * 4 + 1, length: 1))
			w[t] |= tempByte << 16
			data.getBytes(&tempByte, range: NSRange(location: i * 64 + t * 4 + 0, length: 1))
			w[t] |= tempByte << 24
		}
		
		// b. For t = 16 to 79 let
		//    W(t) = S^1(W(t-3) XOR W(t-8) XOR W(t-14) XOR W(t-16)).
		for var t = 16; t < 80; t++ {
			w[t] = circularLeftShift((w[t-3] ^ w[t-8] ^ w[t-14] ^ w[t-16]), 1)
		}
		
		// c. Let A = H0, B = H1, C = H2, D = H3, E = H4.
		var a = h0
		var b = h1
		var c = h2
		var d = h3
		var e = h4
		
		// d. For t = 0 to 79 do
		//    TEMP = S^5(A) + f(t;B,C,D) + E + W(t) + K(t);
		//    E = D;  D = C;  C = S^30(B);  B = A; A = TEMP;
		for t in 0..<80 {
			
			var temp: UInt32 = 0
			
			if t >= 0 && t < 20 {
				temp = circularLeftShift(a, 5) &+ ((b & c) | ((~b) & d)) &+ e &+ w[t] &+ 0x5A827999
			} else if t >= 20 && t < 40 {
				temp = circularLeftShift(a, 5) &+ (b ^ c ^ d) &+ e &+ w[t] &+ 0x6ED9EBA1
			} else if t >= 40 && t < 60 {
				temp = circularLeftShift(a, 5) &+ ((b & c) | (b & d) | (c & d)) &+ e &+ w[t] &+ 0x8F1BBCDC
			} else {	// t >= 60 && t < 80
				temp = circularLeftShift(a, 5) &+ (b ^ c ^ d) &+ e &+ w[t] &+ 0xCA62C1D6
			}
			
			e = d
			d = c
			c = circularLeftShift(b, 30)
			b = a
			a = temp
		}
		
		// e. Let H0 = H0 + A, H1 = H1 + B, H2 = H2 + C, H3 = H3 + D, H4 = H4 + E.
		h0 = h0 &+ a
		h1 = h1 &+ b
		h2 = h2 &+ c
		h3 = h3 &+ d
		h4 = h4 &+ e
	}
	
	let digestData = NSMutableData()
	digestData.appendBytes(&h0, length: 4)
	digestData.appendBytes(&h1, length: 4)
	digestData.appendBytes(&h2, length: 4)
	digestData.appendBytes(&h3, length: 4)
	digestData.appendBytes(&h4, length: 4)
	
	return digestData
}

private func circularLeftShift(x: UInt32, _ n: UInt32) -> UInt32 {
	return (x << n) | (x >> (32-n))
}