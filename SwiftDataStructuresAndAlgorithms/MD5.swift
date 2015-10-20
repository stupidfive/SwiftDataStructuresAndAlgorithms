//
//  MD5.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by George Wu on 10/18/15.
//  Copyright © 2015 George Wu. All rights reserved.
//

import Foundation

public func md5String(string string: String) -> String {
	let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
	return md5String(data: data)
}

public func md5String(data data: NSData) -> String {
	let md5Data = md5(data: data)
	var byte: UInt = 0
	var mdString = ""
	for i in 0..<16 {
		md5Data.getBytes(&byte, range: NSRange(location: i, length: 1))
		mdString.appendContentsOf(String(format: "%02x", byte))
	}
	return mdString
}

public func md5(string string: String) -> NSData {
	let data = string.dataUsingEncoding(NSUTF8StringEncoding)!
	return md5(data: data)
}

/// - see: [https://tools.ietf.org/html/rfc1321](https://tools.ietf.org/html/rfc1321)
public func md5(data data: NSData) -> NSData {
	
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
	
	var lengthInBits = length * 8
	data.appendBytes(&lengthInBits, length: 8)
	
	var a: UInt32 = 0x67452301
	var b: UInt32 = 0xefcdab89
	var c: UInt32 = 0x98badcfe
	var d: UInt32 = 0x10325476
	
	for var i = 0; i < data.length / 64; i++ {
		
		var x = [UInt32](count: 16, repeatedValue: 0)
		for var j = 0; j < 16; j++ {
			data.getBytes(&x[j], range: NSRange(location: i * 64 + j * 4, length: 4))
		}
		
		let aa = a
		let bb = b
		let cc = c
		let dd = d
		
		// round 1
		FF(&a, &b, &c, &d, x[ 0],  7, 3614090360)
		FF(&d, &a, &b, &c, x[ 1], 12, 3905402710)
		FF(&c, &d, &a, &b, x[ 2], 17,  606105819)
		FF(&b, &c, &d, &a, x[ 3], 22, 3250441966)
		FF(&a, &b, &c, &d, x[ 4],  7, 4118548399)
		FF(&d, &a, &b, &c, x[ 5], 12, 1200080426)
		FF(&c, &d, &a, &b, x[ 6], 17, 2821735955)
		FF(&b, &c, &d, &a, x[ 7], 22, 4249261313)
		FF(&a, &b, &c, &d, x[ 8],  7, 1770035416)
		FF(&d, &a, &b, &c, x[ 9], 12, 2336552879)
		FF(&c, &d, &a, &b, x[10], 17, 4294925233)
		FF(&b, &c, &d, &a, x[11], 22, 2304563134)
		FF(&a, &b, &c, &d, x[12],  7, 1804603682)
		FF(&d, &a, &b, &c, x[13], 12, 4254626195)
		FF(&c, &d, &a, &b, x[14], 17, 2792965006)
		FF(&b, &c, &d, &a, x[15], 22, 1236535329)
		
		// round 2
		GG(&a, &b, &c, &d, x[ 1],  5, 4129170786);
		GG(&d, &a, &b, &c, x[ 6],  9, 3225465664);
		GG(&c, &d, &a, &b, x[11], 14,  643717713);
		GG(&b, &c, &d, &a, x[ 0], 20, 3921069994);
		GG(&a, &b, &c, &d, x[ 5],  5, 3593408605);
		GG(&d, &a, &b, &c, x[10],  9,   38016083);
		GG(&c, &d, &a, &b, x[15], 14, 3634488961);
		GG(&b, &c, &d, &a, x[ 4], 20, 3889429448);
		GG(&a, &b, &c, &d, x[ 9],  5,  568446438);
		GG(&d, &a, &b, &c, x[14],  9, 3275163606);
		GG(&c, &d, &a, &b, x[ 3], 14, 4107603335);
		GG(&b, &c, &d, &a, x[ 8], 20, 1163531501);
		GG(&a, &b, &c, &d, x[13],  5, 2850285829);
		GG(&d, &a, &b, &c, x[ 2],  9, 4243563512);
		GG(&c, &d, &a, &b, x[ 7], 14, 1735328473);
		GG(&b, &c, &d, &a, x[12], 20, 2368359562);
		
		// round 3
		HH(&a, &b, &c, &d, x[ 5],  4, 4294588738);
		HH(&d, &a, &b, &c, x[ 8], 11, 2272392833);
		HH(&c, &d, &a, &b, x[11], 16, 1839030562);
		HH(&b, &c, &d, &a, x[14], 23, 4259657740);
		HH(&a, &b, &c, &d, x[ 1],  4, 2763975236);
		HH(&d, &a, &b, &c, x[ 4], 11, 1272893353);
		HH(&c, &d, &a, &b, x[ 7], 16, 4139469664);
		HH(&b, &c, &d, &a, x[10], 23, 3200236656);
		HH(&a, &b, &c, &d, x[13],  4,  681279174);
		HH(&d, &a, &b, &c, x[ 0], 11, 3936430074);
		HH(&c, &d, &a, &b, x[ 3], 16, 3572445317);
		HH(&b, &c, &d, &a, x[ 6], 23,   76029189);
		HH(&a, &b, &c, &d, x[ 9],  4, 3654602809);
		HH(&d, &a, &b, &c, x[12], 11, 3873151461);
		HH(&c, &d, &a, &b, x[15], 16,  530742520);
		HH(&b, &c, &d, &a, x[ 2], 23, 3299628645);
		
		// round 4
		II(&a, &b, &c, &d, x[ 0],  6, 4096336452);
		II(&d, &a, &b, &c, x[ 7], 10, 1126891415);
		II(&c, &d, &a, &b, x[14], 15, 2878612391);
		II(&b, &c, &d, &a, x[ 5], 21, 4237533241);
		II(&a, &b, &c, &d, x[12],  6, 1700485571);
		II(&d, &a, &b, &c, x[ 3], 10, 2399980690);
		II(&c, &d, &a, &b, x[10], 15, 4293915773);
		II(&b, &c, &d, &a, x[ 1], 21, 2240044497);
		II(&a, &b, &c, &d, x[ 8],  6, 1873313359);
		II(&d, &a, &b, &c, x[15], 10, 4264355552);
		II(&c, &d, &a, &b, x[ 6], 15, 2734768916);
		II(&b, &c, &d, &a, x[13], 21, 1309151649);
		II(&a, &b, &c, &d, x[ 4],  6, 4149444226);
		II(&d, &a, &b, &c, x[11], 10, 3174756917);
		II(&c, &d, &a, &b, x[ 2], 15,  718787259);
		II(&b, &c, &d, &a, x[ 9], 21, 3951481745);
		
		a = a &+ aa
		b = b &+ bb
		c = c &+ cc
		d = d &+ dd
	}
	
	let digestData = NSMutableData()
	digestData.appendBytes(&a, length: 4)
	digestData.appendBytes(&b, length: 4)
	digestData.appendBytes(&c, length: 4)
	digestData.appendBytes(&d, length: 4)
	
	return digestData
}

// MARK: - auxiliary functions

func F(x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
	return (((x) & (y)) | ((~x) & (z)))
}

func G(x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
	return (((x) & (z)) | ((y) & (~z)))
}

func H(x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
	return ((x) ^ (y) ^ (z))
}

func I(x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
	return ((y) ^ ((x) | (~z)))
}

func rotateLeft(x: UInt32, _ n: UInt32) -> UInt32 {
	return (((x) << (n)) | ((x) >> (32-(n))))
}

func FF(inout a: UInt32, inout _ b: UInt32, inout _ c: UInt32, inout _ d: UInt32, _ x: UInt32, _ s: UInt32, _ t: UInt32) {
	
	a = a &+ F(b, c, d) &+ x &+ t
	a = rotateLeft(a, s)
	a = a &+ b
}

func GG(inout a: UInt32, inout _ b: UInt32, inout _ c: UInt32, inout _ d: UInt32, _ x: UInt32, _ s: UInt32, _ t: UInt32) {
	
	a = a &+ G(b, c, d) &+ x &+ t
	a = rotateLeft(a, s)
	a = a &+ b
}

func HH(inout a: UInt32, inout _ b: UInt32, inout _ c: UInt32, inout _ d: UInt32, _ x: UInt32, _ s: UInt32, _ t: UInt32) {
	
	a = a &+ H(b, c, d) &+ x &+ t
	a = rotateLeft(a, s)
	a = a &+ b
}

func II(inout a: UInt32, inout _ b: UInt32, inout _ c: UInt32, inout _ d: UInt32, _ x: UInt32, _ s: UInt32, _ t: UInt32) {
	
	a = a &+ I(b, c, d) &+ x &+ t
	a = rotateLeft(a, s)
	a = a &+ b
}
