package ru.maxpostnikov.engine 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class EngineEvent extends Event 
	{
		
		public static const LEVEL_ADDED:String = "LevelAdded";
		public static const LEVEL_MOUSE_OUT:String = "LevelMouseOut";
		public static const LEVEL_MOUSE_OVER:String = "LevelMouseOver";
		
		public static const HUD_MOUSE_OVER:String = "HUDMouseOver";
		
		public static const LOOP_STEP:String = "LoopStep";
		public static const LOOP_STOP:String = "LoopStop";
		
		public static const ENTITY_ADDED:String = "EntityAdded";
		public static const ENTITY_REMOVED:String = "EntityRemoved";
		
		public var parameter:Object;
		
		public function EngineEvent(type:String, parameter:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.parameter = parameter;
		} 
		
		public override function clone():Event 
		{ 
			return new EngineEvent(type, parameter, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EngineEvent", "type", "parameter", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}