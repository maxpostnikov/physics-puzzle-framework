package ru.maxpostnikov.engine.entities 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.components.ComponentGroup;
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
			for each (var component:Component in _components) {
				if (component is ComponentGroup && (component as ComponentGroup).skin) {
					var position:Point = new Point(component.body.GetPosition().x * Engine.RATIO, component.body.GetPosition().y * Engine.RATIO);
					var postition2:Point = (component as ComponentGroup).skin.globalToLocal(new Point(position.x, position.y));
					
					(component as ComponentGroup).skin.x = postition2.x;
					(component as ComponentGroup).skin.y = postition2.y;
					/*var rotation:Number = component.body.GetAngle() * 180 / Math.PI;
					if (Math.abs(rotation) > 360) 
						rotation %= 360;
					(component as ComponentGroup).skin.rotation = rotation;*/
				}
			}
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