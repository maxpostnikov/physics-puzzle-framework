package ru.maxpostnikov.engine.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class KeyInput 
	{
		
		private static const _KEY_R:int = 82;
		private static const _KEY_D:int = 68;
		private static const _KEY_P:int = 80;
		private static const _KEY_LEFT:int = 37;
		private static const _KEY_RIGHT:int = 39;
		
		public function KeyInput(container:DisplayObjectContainer) 
		{
			container.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (!Engine.getInstacne().isPaused && !Engine.getInstacne().isPausedLoop) {
				if (e.keyCode == _KEY_R)
					Engine.getInstacne().restartLevel();
				
				if (Engine.getInstacne().isDebugAllowed) {
					if (e.keyCode == _KEY_D)
						Engine.getInstacne().debug();
					else if (e.keyCode == _KEY_LEFT)
						Engine.getInstacne().openPrevLevel();
					else if (e.keyCode == _KEY_RIGHT)
						Engine.getInstacne().openNextLevel();
				}
			}
			
			if (e.keyCode == _KEY_P)
				Engine.getInstacne().pause();
		}
		
	}

}