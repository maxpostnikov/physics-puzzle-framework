package ru.maxpostnikov.engine.ui 
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import ru.maxpostnikov.game.GameContent;
	import ru.maxpostnikov.engine.ui.screens.Screen;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Canvas 
	{
		
		private var _screens:Dictionary;
		private var _container:DisplayObjectContainer;
		
		public function Canvas(container:DisplayObjectContainer) 
		{
			_container = container;
			_screens = new Dictionary();
			
			for each (var screenClass:Class in GameContent.SCREENS) {
				var screen:Screen = new screenClass();
				_screens[screen.getID()] = screen;
			}
		}
		
		public function showScreen(id:uint, data:Object = null):void 
		{
			var screen:Screen = _screens[id];
			
			if (screen) {
				screen.show(data);
				_container.addChild(screen);
			}
		}
		
		public function updateScreen(id:uint, data:Object):void 
		{
			var screen:Screen = _screens[id];
			
			if (screen)
				screen.update(data);
		}
		
		public function hideScreen(id:uint):void 
		{
			var screen:Screen = _screens[id];
			
			if (screen) {
				screen.hide();
				_container.removeChild(screen);
			}
		}
		
	}

}