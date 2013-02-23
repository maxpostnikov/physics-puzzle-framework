package ru.maxpostnikov.engine.ui 
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import ru.maxpostnikov.game.GameData;
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
			
			for each (var screenClass:Class in GameData.SCREENS) {
				var screen:Screen = new screenClass();
				_screens[screen.getID()] = screen;
			}
		}
		
		public function showScreen(id:uint, data:Object = null):void 
		{
			var screen:Screen = _screens[id];
			
			screen.show(data);
			_container.addChild(screen);
		}
		
		public function hideScreen(id:uint):void 
		{
			var screen:Screen = _screens[id];
			
			screen.hide();
			_container.removeChild(screen);
		}
		
	}

}