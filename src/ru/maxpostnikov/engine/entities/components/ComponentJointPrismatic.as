package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentJointPrismatic extends ComponentJoint
	{
		
		override public function createJointDef(bodies:Vector.<b2Body>):b2JointDef 
		{
			var jointDef:b2JointDef;
			
			jointDef = new b2PrismaticJointDef();
			jointDef.userData = this;
			jointDef.collideConnected = this.collideConnected;
			
			(jointDef as b2PrismaticJointDef).enableLimit = this.enableLimit;
			(jointDef as b2PrismaticJointDef).enableMotor = this.enableMotor;
			(jointDef as b2PrismaticJointDef).lowerTranslation = this.lowerTranslation / Engine.RATIO;
			(jointDef as b2PrismaticJointDef).upperTranslation = this.upperTranslation / Engine.RATIO;
			(jointDef as b2PrismaticJointDef).maxMotorForce = this.maxMotorForce;
			(jointDef as b2PrismaticJointDef).motorSpeed = this.motorSpeed;
			
			var angle:Number = Utils.angleInRadians(this.rotation + this.parent.rotation);
			var axis:b2Vec2 = new b2Vec2(Math.cos(angle), Math.sin(angle));
			(jointDef as b2PrismaticJointDef).Initialize(bodies[0], bodies[1], bodies[0].GetWorldCenter(), axis);
			
			return jointDef;
		}
		
	}

}