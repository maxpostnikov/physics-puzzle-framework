package ru.maxpostnikov.engine.ui 
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import ru.maxpostnikov.engine.ui.screens.Screen;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Canvas 
	{
		
		private var _screens:Dictionary;
		private var _container:DisplayObjectContainer;
		
		public function Canvas(container:DisplayObjectContainer, screens:Vector.<Screen>) 
		{
			_container = container;
			_screens = new Dictionary();
			
			for each (var screen:Screen in screens)
				_screens[screen.getID()] = screen;
		}
		
		public function showScreen(id:String, data:Object = null):void 
		{
			var screen:Screen = _screens[id];
			
			if (screen) {
				screen.show(data);
				_container.addChild(screen);
			}
		}
		
		public function updateScreen(id:String, data:Object):void 
		{
			var screen:Screen = _screens[id];
			
			if (screen)
				screen.update(data);
		}
		
		public function hideScreen(id:String):void 
		{
			var screen:Screen = _screens[id];
			
			if (screen) {
				screen.hide();
				_container.removeChild(screen);
			}
		}
		
	}

}