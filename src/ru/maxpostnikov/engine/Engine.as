package ru.maxpostnikov.engine 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import ru.maxpostnikov.engine.core.Loop;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.Entity;
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
		
		public function addEntity(entity:Entity):void 
		{
			addToQueue(entity);
		}
		
		public function removeEntity(entity:Entity):void 
		{
			addToQueue(entity);
		}
		
		public function removeComponent(component:Component):void 
		{
			addToQueue(component);
		}
		
		private function addToQueue(entity:MovieClip):void 
		{
			if (_loop.queue.indexOf(entity) < 0) _loop.queue.push(entity);
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