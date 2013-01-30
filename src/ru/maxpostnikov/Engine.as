package ru.maxpostnikov 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Engine 
	{
		
		public static const RATIO:Number = 30;
		
		private var _loop:Loop;
		
		private static var _instance:Engine;
		
		public function Engine(singleton:PrivateClass) 
		{
			_instance = this;
		}
		
		public static function getInstacne():Engine 
		{
			return (_instance) ? _instance : new Engine(new PrivateClass());
		}
		
		public function launch(container:DisplayObjectContainer):void 
		{
			_loop = new Loop(container, RATIO);
		}
		
	}

}

class PrivateClass
{
	public function PrivateClass():void 
	{
		trace("Engine instantiated.");
	}
}