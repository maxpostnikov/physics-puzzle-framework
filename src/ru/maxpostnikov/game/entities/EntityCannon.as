package ru.maxpostnikov.game.entities 
{
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.components.ComponentJoint;
	import ru.maxpostnikov.engine.entities.Entity;
	import ru.maxpostnikov.utilities.Utils;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class EntityCannon extends Entity
	{
		
		private const _SPEED_MULTIPLIER:Number = -5;
		
		private var _joint:b2RevoluteJoint;
		
		override public function update():void 
		{
			if (!_joint) 
				_joint = getJoint();
			else
				rotateToCursor();
			
			super.update();
		}
		
		private function rotateToCursor():void 
		{
			var angle:Number = Utils.angleInDegrees(Math.atan2(this.mouseY, this.mouseX)) - this.initialRotation;
			
			if (angle > 90)
				angle -= 360;
			else if (angle < -270)
				angle += 360;
			
			_joint.SetMotorSpeed(_SPEED_MULTIPLIER * (_joint.GetJointAngle() - Utils.angleInRadians(angle)));
		}
		
		private function getJoint():b2RevoluteJoint 
		{
			for each (var component:Component in components) {
				if (component is ComponentJoint)
					return (component as ComponentJoint).joint as b2RevoluteJoint;
			}
			
			return null;
		}
		
	}

}