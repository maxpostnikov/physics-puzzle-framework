package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.IProcessable;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Component extends MovieClip implements IProcessable
	{
		
		public var body:b2Body;
		public var bodyDef:b2BodyDef;
		public var fixtureDefs:Vector.<b2FixtureDef>;
		
		private var _isRemoved:Boolean;
		
		public function Component() 
		{
			this.mouseChildren = false;
		}
		
		public function add():void 
		{
			//Override
		}
		
		public function remove():void 
		{
			//this.parent.removeChild(this);
			this.visible = false;
			
			_isRemoved = true;
			Engine.getInstacne().process(this);
			
			bodyDef = null;
			fixtureDefs = null;
		}
		
		public function synchronize():void 
		{
			if (body && body.GetType() != b2Body.b2_staticBody) {
				var position:Point = this.parent.globalToLocal(new Point(body.GetPosition().x * Engine.RATIO, 
																		 body.GetPosition().y * Engine.RATIO));
				var rotation:Number = Utils.angleInDegrees(body.GetAngle());
				if (Math.abs(rotation) > 360) rotation %= 360;
				
				this.x = position.x;
				this.y = position.y;
				this.rotation = rotation;
			}
		}
		
		public function isOutsideBorder():Boolean 
		{
			if (body && body.GetType() != b2Body.b2_staticBody) {
				var position:Point = new Point(body.GetPosition().x * Engine.RATIO, 
											   body.GetPosition().y * Engine.RATIO);
				
				if (position.y - (this.height / 2) > Engine.getInstacne().height ||
					position.y + (this.height / 2) < 0 || 
					position.x - (this.width / 2) > Engine.getInstacne().width || 
					position.x + (this.width / 2) < 0) {
					return true;
				}
			}
			
			return false;
		}
		
		protected function hide():void 
		{
			for (var i:int = 0; i < numChildren; i++)
				getChildAt(i).visible = false;
		}
		
		public function get isRemoved():Boolean { return _isRemoved; }
		
	}

}