PopH264 Swift Package
=========================

This repository is a release/build repositor for use with xcode & Swift Package Manager for [PopH264](https://github.com/NewChromantics/PopH264)

This is currently manually maintained.

Discovered that the binary target can be a zipped url, which can come from github releases.
- Need to generate checksum; https://developer.apple.com/forums/thread/655951 
	- `swift package compute-checksum some.xcframework.zip`
- todo: auto generate [future] url & checksum in PopH264's github action and then can have `Package.swift` in the Poph264 repository?

