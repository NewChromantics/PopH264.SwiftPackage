import SwiftUI
import PopH264Objc


struct PopH264Error : LocalizedError
{
	let error: String

	init(_ description: String) {
		error = description
	}

	var errorDescription: String? {
		error
	}
}


public struct PlaneMeta: Decodable
{
	public let Channels : Int
	public let DataSize : Int
	public let Format : String	//	make this an enum
	public let Width : Int
	public let Height : Int
}

public struct PopH264PeekMeta: Decodable
{
	public var Error : String? = nil
	public var DecodedTimeMs : Int? = nil
	public var NowTimeMs : Int? = nil
	public var FrameNumber : Int? = nil
	public var QueuedFrames : Int? = nil
	public var HardwareAccelerated : Bool? = nil
	public var Planes : [PlaneMeta]? = nil
	
	public init(error:String?=nil)
	{
		Error = error
	}

}


public class PopH264Instance
{
	var instanceWrapper : PopH264DecoderWrapper
	var allocationError : String?

	public init()
	{
		do
		{
			instanceWrapper = PopH264DecoderWrapper()
			try instanceWrapper.allocate()
			var Version = PopH264_GetVersion_NSString()
			print("Allocated instance \(instanceWrapper); PopH264 version \(Version)")
		}
		catch
		{
			allocationError = error.localizedDescription
		}
	}
	
	public func PushData(data:Data,frameNumber:Int32)
	{
		instanceWrapper.push(data,frameNumber: frameNumber)
	}
	
	public func PushEndOfFile()
	{
		instanceWrapper.pushEndOfFile()
	}

	
	
	public func PeekNextFrame() async -> PopH264PeekMeta
	{
		if ( allocationError != nil )
		{
			//return Mp4Meta( eror:allocationError, RootAtoms:nil, IsFinished:true, Mp4BytesParsed:0 )
			return PopH264PeekMeta( error:allocationError! )
		}
		
		do
		{
			//var StateJson = try instanceWrapper.getDecoderStateJson()
			var StateJson = try instanceWrapper.peekNextFrameJson()
			//print(StateJson)
			
			
			let StateJsonData = StateJson.data(using: .utf8)!
			let Meta = try! JSONDecoder().decode(PopH264PeekMeta.self, from: StateJsonData)
			return Meta
		}
		catch let error as Error
		{
			let OutputError = "Error getting decoder state; \(error.localizedDescription)"
			return PopH264PeekMeta( error:OutputError )
		}
	}
	
	//	returns frame number popped
	public func PopNextFrame() async throws -> Int
	{
		//	todo: get plane data!
		var NextFrame = try instanceWrapper.popNextFrame()
		return Int(NextFrame)
	}

}

