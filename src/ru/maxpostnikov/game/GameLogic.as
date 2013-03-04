package ru.maxpostnikov.game 
{
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.entities.Entity;
	import ru.maxpostnikov.game.entities.EntityProjectile;
	import ru.maxpostnikov.game.entities.EntityTarget;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class GameLogic 
	{
		
		private static const _PROJECTILES_TOTAL:int = 1;
		
		private static var _targetsTotal:int;
		private static var _targetsCollected:int;
		private static var _projectilesCreated:int;
		
		public static function reset():void 
		{
			_targetsTotal = 0;
			_targetsCollected = 0;
			_projectilesCreated = 0;
		}
		
		public static function onEntityAdded(entity:Entity):void 
		{
			if (entity is EntityTarget)
				_targetsTotal++;
			else if (entity is EntityProjectile)
				_projectilesCreated++;
			
			if (_projectilesCreated > _PROJECTILES_TOTAL)
				Engine.getInstacne().removeFirstEntityOfType(EntityProjectile);
		}
		
		public static function onEntityRemoved(entity:Entity):void 
		{
			if (entity is EntityTarget)
				_targetsCollected++;
			else if (entity is EntityProjectile)
				_projectilesCreated--;
			
			if (_projectilesCreated < 0) _projectilesCreated = 0;
		}
		
		public static function onLoopStep():void 
		{
			if (_targetsTotal == _targetsCollected && _targetsCollected != 0) {
				trace("WINNING HERE!!");
				Engine.getInstacne().win();
			}
		}
		
	}

}