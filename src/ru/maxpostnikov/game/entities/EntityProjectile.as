package ru.maxpostnikov.game.entities 
{
	import Box2D.Dynamics.b2Fixture;
	import ru.maxpostnikov.engine.core.ContactListener;
	import ru.maxpostnikov.engine.entities.Entity;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class EntityProjectile extends Entity
	{
		
		override public function contact(type:String, fixture:b2Fixture, entity:Entity, impulse:Number):void 
		{
			if (type == ContactListener.BEGIN_CONTACT && entity is EntityTarget) {
				entity.remove();
				(entity as EntityTarget).isCollected = true;
			}
		}
		
	}

}