# Swift Data Structures and Algorithms

A implementation of classical data structures and algorithms in Apple's newly released Swift 2. 

## Features

Implemented data structures and algorithms including

- Linked list
	* Singly linked list
	* Doubly linked list
- Tree
	* Binary search tree
	* Splay tree
	* Red-black tree
- Sorting
	* Bubble sort
	* Insertion sort
	* Selection sort
	* Merge sort
	* Quick sort
- Encryption and encoding
	* MD5
	* SHA-1
	* Base64
- Others
	* Stack 
	* Queue

with more on the way.

## Usage

Simply import all the source files to your project and you're on your way.

Notice that some classes are subclassing or including others to take advantage of code reuse. So be sure to check out their dependenies if you only want to import a few of them (which I believe to be a nasty business since Swift does not have `#import` like Objective-C).