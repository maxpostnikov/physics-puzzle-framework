package ru.maxpostnikov.engine.entities 
{
	import Box2D.Dynamics.b2Fixture;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.components.Component;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Entity extends MovieClip implements IProcessable
	{
		
		private var _isRemoved:Boolean;
		private var _components:Vector.<Component>;
		
		public function Entity()
		{
			_components = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_components.push(child as Component);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			for each (var component:Component in _components)
				component.add();
			
			Engine.getInstacne().process(this);
		}
		
		public function remove():void 
		{
			for (var i:int = _components.length - 1; i >= 0; i--)
				removeComponent(_components[i]);
			
			this.parent.removeChild(this);
			
			_isRemoved = true;
			Engine.getInstacne().process(this);
			
			_components = null;
		}
		
		public function update():void 
		{
			for each (var component:Component in _components) {
				component.synchronize();
				
				if (component.isOutsideBorder()) removeComponent(component, true);
			}
		}
		
		public function contact(type:String, fixture:b2Fixture, entity:Entity, impulse:Number):void 
		{
			//Override
		}
		
		private function removeComponent(component:Component, full:Boolean = false):void 
		{
			_components.splice(_components.indexOf(component), 1);
			
			component.remove();
			
			if (full && _components.length == 0) remove();
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
	}

}