package ru.maxpostnikov.engine.entities 
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.utilities.Utils;
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
			}
			
			Engine.getInstacne().addEntity(this);
		}
		
		public function remove():void 
		{
			_isRemoved = true;
			
			Engine.getInstacne().removeEntity(this);
		}
		
		public function update():void 
		{
			synchronize();
		}
		
		private function synchronize():void 
		{
			for each (var component:Component in _components) {
				if (component.body && component.body.GetType() != b2Body.b2_staticBody) {
					var position:Point = this.globalToLocal(new Point(component.body.GetPosition().x * Engine.RATIO, 
																	  component.body.GetPosition().y * Engine.RATIO));
					var rotation:Number = Utils.angleInDegrees(component.body.GetAngle());
					if (Math.abs(rotation) > 360) rotation %= 360;
					
					component.x = position.x;
					component.y = position.y;
					component.rotation = rotation;
					
					var size:Point = Utils.realSize(component); 
					var pos:Point = this.localToGlobal(new Point(component.x, component.y)); trace(stage.stageWidth, stage.stageHeight, size, pos.x, pos.y);
					
					if (pos.y /*- (size.y / 2)*/ > stage.stageHeight || 
						pos.x /*- (size.x / 2)*/ > stage.stageWidth || 
						pos.y /*+ (size.y / 2)*/ < 0 || 
						pos.x /*+ (size.x / 2)*/ < 0) {
						_components.splice(_components.indexOf(component), 1);
						Engine.getInstacne().removeComponent(component);
					}
				}
			}
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
		public function get components():Vector.<Component> { return _components; }
		
	}

}