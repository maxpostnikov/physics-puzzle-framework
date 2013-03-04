package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentJoint extends Component
	{
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var collideConnected:Boolean = false;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var enableMotor:Boolean = false;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var maxMotorTorque:Number = 0;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var motorSpeed:Number = 0;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var maxMotorForce:Number = 0;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var enableLimit:Boolean = false;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var lowerAngle:Number = 0;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var upperAngle:Number = 0;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var lowerTranslation:Number = 0;
		
		[Inspectable(type="Number", defaultValue=0)]
		public var upperTranslation:Number = 0;
		
		public var joint:b2Joint;
		
		protected var anchors:int = 1;
		
		private var _anchorPoints:Vector.<Point>;
		
		public function ComponentJoint() 
		{
			hide();
			
			_anchorPoints = new <Point>[];
		}
		
		override public function add():void 
		{
			Utils.rotateInsideOut(this);
			
			for (var i:int = 1; i <= anchors; i++) {
				var point:Point = new Point(this.x + this['point_' + i].x, this.y + this['point_' + i].y);
				point = this.parent.localToGlobal(point);
				point.x /= Engine.RATIO;
				point.y /= Engine.RATIO;
				
				_anchorPoints.push(point);
			}
			
			super.add();
		}
		
		override public function remove():void 
		{
			super.remove();
			
			joint = null;
			_anchorPoints = null;
		}
		
		public function createJointDef(bodies:Vector.<b2Body>):b2JointDef 
		{
			throw Error("Joints subclasses must override this");
		}
		
		public function get anchorPoints():Vector.<Point> { return _anchorPoints; }
		
	}

}