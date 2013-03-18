package ru.maxpostnikov.game.entities 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.effects.MCEffect;
	import ru.maxpostnikov.engine.Engine;
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
		
		private const _JOINT_SPEED_MULTIPLIER:Number = -5;
		private const _PROJECTILE_OFFSET_X:Number = 130;
		private const _PROJECTILE_OFFSET_Y:Number = -30;
		private const _PROJECTILE_SPEED_MIN:Number = 100;
		private const _PROJECTILE_SPEED_MAX:Number = 600;
		
		private var _barrel:MovieClip;
		private var _joint:b2RevoluteJoint;
		private var _projectile:EntityProjectile;
		
		public function EntityCannon() 
		{
			super();
			
			if ((this as MovieClip).barrel && (this as MovieClip).barrel.visual)
				_barrel = (this as MovieClip).barrel.visual;
			
			this.parent.addEventListener(MouseEvent.MOUSE_DOWN, onLevelClick, false, 0, true);
		}
		
		override public function remove():void 
		{
			this.parent.removeEventListener(MouseEvent.MOUSE_DOWN, onLevelClick);
			
			_joint = null;
			_barrel = null;
			_projectile = null;
			
			super.remove();
		}
		
		override public function update():void 
		{
			if (!_joint) {
				_joint = getJoint();
			} else {
				rotateToCursor();
				
				if (_projectile && _projectile.isAllBodiesCreated)
					applyImpulse();
			}
			
			super.update();
		}
		
		private function onLevelClick(e:MouseEvent):void 
		{
			if (!_projectile) {
				_projectile = new Entity_Ragdoll();
				
				var angle:Number = _joint.GetJointAngle() + Utils.angleInRadians(this.initialRotation);
				var position:Point = new Point((Math.cos(angle) * _PROJECTILE_OFFSET_X) - (Math.sin(angle) * _PROJECTILE_OFFSET_Y) + this.x,
											   (Math.sin(angle) * _PROJECTILE_OFFSET_X) + (Math.cos(angle) * _PROJECTILE_OFFSET_Y) + this.y);
				
				_projectile.x = position.x;
				_projectile.y = position.y;
				
				this.parent.addChild(_projectile);
				
				var effect:MCEffect = new Effect_Bang();
				effect.init(this, globalToLocal(new Point(position.x, position.y)));
			}
		}
		
		private function applyImpulse():void 
		{
			var randomOffset:Number = 0;
			var angle:Number = _joint.GetJointAngle() + Utils.angleInRadians(this.initialRotation);
			var speed:Number = _PROJECTILE_SPEED_MIN + Point.distance(new Point(this.x, this.y), new Point(this.parent.mouseX, this.parent.mouseY));
			if (speed > _PROJECTILE_SPEED_MAX) speed = _PROJECTILE_SPEED_MAX;
			
			for each (var component:Component in _projectile.components) {
				if (!(component is ComponentJoint)) {
					randomOffset = Utils.randomNumber( -0.5, 0.5, 0.1);
					var impulse:Number = component.body.GetMass() * (speed / Engine.RATIO);
					
					component.body.ApplyImpulse(new b2Vec2(impulse * Math.cos(angle), impulse * Math.sin(angle)), 
												new b2Vec2(component.body.GetWorldCenter().x + randomOffset, component.body.GetWorldCenter().y + randomOffset));
				}
			}
			
			_projectile = null;
		}
		
		private function rotateToCursor():void 
		{
			var angle:Number = Utils.angleInDegrees(Math.atan2(this.mouseY, this.mouseX)) - this.initialRotation;
			
			if (angle > 90)
				angle -= 360;
			else if (angle < -270)
				angle += 360;
			
			_joint.SetMotorSpeed(_JOINT_SPEED_MULTIPLIER * (_joint.GetJointAngle() - Utils.angleInRadians(angle)));
			
			if (_barrel)
				mirror(_joint.GetJointAngle());
		}
		
		private function mirror(angle:Number):void 
		{
			angle = Utils.angleInDegrees(angle);
			
			if (angle < -90 || angle > 90)
				_barrel.gotoAndStop(2);
			else
				_barrel.gotoAndStop(1);
		}
		
		private function getJoint():b2RevoluteJoint 
		{
			for each (var component:Component in this.components) {
				if (component is ComponentJoint)
					return (component as ComponentJoint).joint as b2RevoluteJoint;
			}
			
			return null;
		}
		
	}

}