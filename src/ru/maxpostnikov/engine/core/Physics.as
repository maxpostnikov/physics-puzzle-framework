package ru.maxpostnikov.engine.core 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import ru.maxpostnikov.engine.entities.components.Component;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	internal class Physics 
	{
		
		private const _GRAVITY_X:Number = 0;
		private const _GRAVITY_Y:Number = 10;
		
		private const _DT:Number = 1 / 30;
		private const _ITERATIONS_VELOCITY:int = 12;
		private const _ITERATIONS_POSITION:int = 15;
		
		private const _DEBUGDRAW_ALPHA:Number = 0.8;
		private const _DEBUGDRAW_LINETHICKNESS:Number = 2;
		
		private var _world:b2World;
		
		public function Physics(ratio:Number, contactListener:b2ContactListener, debugSprite:Sprite = null) 
		{
			_world = new b2World(new b2Vec2(_GRAVITY_X, _GRAVITY_Y), true);
			_world.SetContactListener(contactListener);
			
			initDebugDraw(ratio, debugSprite);
		}
		
		public function step():void 
		{
			_world.Step(_DT, _ITERATIONS_VELOCITY, _ITERATIONS_POSITION);
			_world.ClearForces();
			
			_world.DrawDebugData();
		}
		
		public function addBody(component:Component):void 
		{
			var body:b2Body = _world.CreateBody(component.bodyDef);
			body.CreateFixture(component.fixtureDef);
			
			body.SetAngle(component.rotation * Math.PI / 180);
			body.SetUserData(component);
		}
		
		private function initDebugDraw(ratio:Number, sprite:Sprite):void 
		{
			if (sprite) {
				var debugDraw:b2DebugDraw = new b2DebugDraw();
				debugDraw.SetSprite(sprite);
				debugDraw.SetDrawScale(ratio);
				debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
				debugDraw.SetFillAlpha(_DEBUGDRAW_ALPHA);
				debugDraw.SetLineThickness(_DEBUGDRAW_LINETHICKNESS);
				
				_world.SetDebugDraw(debugDraw);
			}
		}
		
		public function get world():b2World { return _world; }
		
	}

}