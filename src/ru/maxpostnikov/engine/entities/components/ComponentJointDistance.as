package ru.maxpostnikov.engine.entities.components 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2JointDef;
	import ru.maxpostnikov.engine.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentJointDistance extends ComponentJoint
	{
		
		override public function add():void 
		{
			anchors = 2;
			Utils.transmitRotation(this);
			
			super.add();
		}
		
		override public function createJointDef(bodies:Vector.<b2Body>):b2JointDef 
		{
			var jointDef:b2JointDef;
			
			jointDef = new b2DistanceJointDef();
			jointDef.userData = this;
			jointDef.collideConnected = this.collideConnected;
			
			(jointDef as b2DistanceJointDef).Initialize(bodies[0], bodies[1], bodies[0].GetWorldCenter(), bodies[1].GetWorldCenter());
			
			return jointDef;
		}
		
	}

}