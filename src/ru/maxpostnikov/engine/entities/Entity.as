package ru.maxpostnikov.engine.entities 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.components.Component;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Entity extends MovieClip
	{
		
		private var _isRemoved:Boolean;
		private var _components:Vector.<Component>;
		
		public function Entity()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_components = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_components.push(child as Component);
				else
					child.visible = false;
			}
			
			Engine.getInstacne().addEntity(this);
		}
		
		public function update():void 
		{
			
		}
		
		public function remove():void 
		{
			_isRemoved = true;
			
			Engine.getInstacne().removeEntiry(this);
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
		public function get components():Vector.<Component> { return _components; }
		
	}

}