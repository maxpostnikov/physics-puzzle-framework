package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentJointRevolute extends ComponentJoint
	{
		
		override public function createJointDef(bodies:Vector.<b2Body>):b2JointDef 
		{
			var jointDef:b2JointDef;
			
			jointDef = new b2RevoluteJointDef();
			jointDef.userData = this;
			jointDef.collideConnected = this.collideConnected;
			
			(jointDef as b2RevoluteJointDef).enableLimit = this.enableLimit;
			(jointDef as b2RevoluteJointDef).lowerAngle = this.lowerAngle;
			(jointDef as b2RevoluteJointDef).upperAngle = this.upperAngle;
			(jointDef as b2RevoluteJointDef).enableMotor = this.enableMotor;
			(jointDef as b2RevoluteJointDef).motorSpeed = this.motorSpeed;
			(jointDef as b2RevoluteJointDef).maxMotorTorque = this.maxMotorTorque;
			
			(jointDef as b2RevoluteJointDef).Initialize(bodies[0], bodies[1], new b2Vec2(anchorPoints[0].x, anchorPoints[0].y));
			
			return jointDef;
		}
		
	}

}