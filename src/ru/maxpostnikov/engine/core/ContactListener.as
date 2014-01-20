package ru.maxpostnikov.engine.core 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import ru.maxpostnikov.engine.entities.components.Component;
	import ru.maxpostnikov.engine.entities.Entity;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ContactListener extends b2ContactListener
	{
		
		public static const BEGIN_CONTACT:String = "BeginContact";
		public static const END_CONTACT:String = "EndContact";
		public static const PRE_SOLVE:String = "PreSolve";
		public static const POST_SOLVE:String = "PostSolve";
		
		override public function BeginContact(contact:b2Contact):void 
		{
			sendContact(BEGIN_CONTACT, contact);
		}
		
		override public function EndContact(contact:b2Contact):void 
		{
			sendContact(END_CONTACT, contact);
		}
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			sendContact(PRE_SOLVE, contact);
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			sendContact(POST_SOLVE, contact, impulse.normalImpulses[0]);
		}
		
		private function sendContact(type:String, contact:b2Contact, impulse:Number = 0):void 
		{
			var componentA:Component = contact.GetFixtureA().GetBody().GetUserData() as Component;
			var componentB:Component = contact.GetFixtureB().GetBody().GetUserData() as Component;
			
			if (!componentA.isRemoved && !componentB.isRemoved) {
				var entityA:Entity = componentA.parent as Entity;
				var entityB:Entity = componentB.parent as Entity;
				
				entityA.contact(type, contact.GetFixtureA(), entityB, contact.GetFixtureB(), impulse);
				entityB.contact(type, contact.GetFixtureB(), entityA, contact.GetFixtureA(), impulse);
			}
		}
		
	}

}