package ru.maxpostnikov.engine.core 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.components.ComponentJoint;
	import ru.maxpostnikov.engine.entities.components.ComponentPrimitive;
	import ru.maxpostnikov.engine.utilities.Utils;
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
		
		public var isDebuged:Boolean;
		
		private var _world:b2World;
		private var _jointMouse:b2MouseJoint;
		private var _jointBodies:Vector.<b2Body>;
		private var _jointComponent:ComponentJoint;
		
		public function Physics(ratio:Number, contactListener:b2ContactListener, debugSprite:Sprite = null) 
		{
			_world = new b2World(new b2Vec2(_GRAVITY_X, _GRAVITY_Y), true);
			_world.SetContactListener(contactListener);
			
			initDebugDraw(ratio, debugSprite);
		}
		
		public function step(mousePosition:Point):void 
		{
			_world.Step(_DT, _ITERATIONS_VELOCITY, _ITERATIONS_POSITION);
			_world.ClearForces();
			
			if (_jointMouse) 
				_jointMouse.SetTarget(new b2Vec2(mousePosition.x, mousePosition.y));
			
			if (isDebuged) _world.DrawDebugData();
		}
		
		public function addBody(component:Component):void 
		{
			var body:b2Body = _world.CreateBody(component.bodyDef);
			for each (var fixtureDef:b2FixtureDef in component.fixtureDefs)
				body.CreateFixture(fixtureDef);
			
			if (component is ComponentPrimitive)
				body.SetAngle(Utils.angleInRadians(component.rotation));
			
			component.body = body;
			body.SetUserData(component);
		}
		
		public function removeBody(component:Component):void 
		{
			_world.DestroyBody(component.body);
			
			component.body = null;
		}
		
		public function addMouseJoint(component:Component, force:Number):void 
		{
			if (_jointMouse) removeMouseJoint();
			
			var jointDef:b2MouseJointDef = new b2MouseJointDef();
			jointDef.bodyA = _world.GetGroundBody();
			jointDef.bodyB = component.body;
			jointDef.target.Set(component.body.GetPosition().x, component.body.GetPosition().y);
			jointDef.maxForce = force * component.body.GetMass();
			jointDef.dampingRatio = 1;
			
			_jointMouse = _world.CreateJoint(jointDef) as b2MouseJoint;
		}
		
		public function removeMouseJoint():void 
		{
			if (_jointMouse) {
				_world.DestroyJoint(_jointMouse);
				_jointMouse = null;
			}
		}
		
		public function addJoint(component:ComponentJoint):void 
		{
			queryPoints(component.anchorPoints, component);
			
			if (_jointBodies.length == 0)
				queryPoints(component.anchorPoints);
			
			if (_jointBodies.length > 0) {
				if (_jointBodies.length == 1) _jointBodies.push(_world.GetGroundBody());
				
				component.joint = _world.CreateJoint(component.createJointDef(_jointBodies));
			}
		}
		
		private function queryPoints(points:Vector.<Point>, component:ComponentJoint = null):void 
		{
			_jointComponent = component;
			_jointBodies = new <b2Body>[];
			
			for each (var point:Point in points)
				_world.QueryPoint(queryPointsCallback, new b2Vec2(point.x, point.y));
		}
		
		private function queryPointsCallback(fixture:b2Fixture):Boolean 
		{
			var body:b2Body = fixture.GetBody();
			
			if ((!_jointComponent || (_jointComponent && _jointComponent.parent == (body.GetUserData() as Component).parent)) && _jointBodies.indexOf(body) < 0)
				_jointBodies.push(body);
			
			return true;
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
		
	}

}