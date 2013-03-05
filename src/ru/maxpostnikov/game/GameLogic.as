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
		
		private const _PROJECTILES_TOTAL:int = 1;
		
		private var _isWinning:Boolean;
		private var _targetsTotal:int;
		private var _targetsCollected:int;
		private var _projectilesCreated:int;
		
		private static var _instance:GameLogic;
		
		public function GameLogic(singleton:PrivateClass) 
		{
			_instance = this;
		}
		
		public static function getInstacne():GameLogic 
		{
			return (_instance) ? _instance : new GameLogic(new PrivateClass());
		}
		
		public function init():void 
		{
			_isWinning = false;
			
			_targetsTotal = 0;
			_targetsCollected = 0;
			_projectilesCreated = 0;
		}
		
		public function onEntityAdded(entity:Entity):void 
		{
			if (entity is EntityTarget)
				_targetsTotal++;
			else if (entity is EntityProjectile)
				_projectilesCreated++;
			
			if (_projectilesCreated > _PROJECTILES_TOTAL)
				Engine.getInstacne().removeFirstEntityOfType(EntityProjectile);
		}
		
		public function onEntityRemoved(entity:Entity):void 
		{
			if (entity is EntityTarget && (entity as EntityTarget).isCollected)
				_targetsCollected++;
			else if (entity is EntityProjectile)
				_projectilesCreated--;
			
			if (_projectilesCreated < 0) _projectilesCreated = 0;
		}
		
		public function onLoopStep():void 
		{
			if (!_isWinning && _targetsTotal != 0 && _targetsTotal == _targetsCollected) {
				_isWinning = true;
				
				Engine.getInstacne().win();
			}
		}
		
	}

}

class PrivateClass { }