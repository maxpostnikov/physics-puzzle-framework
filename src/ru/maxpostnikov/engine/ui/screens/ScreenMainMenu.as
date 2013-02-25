package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.DisplayObject;
	import ru.maxpostnikov.engine.ui.buttons.ButtonPlay;
	import ru.maxpostnikov.engine.ui.buttons.ButtonResume;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenMainMenu extends Screen
	{
		
		public static const ID:uint = 1;
		
		private var _isResumed:Boolean;
		
		public function ScreenMainMenu() 
		{
			visual = new mainMenu();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			super.show(data);
			
			_isResumed = data.isResumed;
			
			if (_isResumed) {
				for (var i:int = 0; i < visual.numChildren; i++) {
					var child:DisplayObject = visual.getChildAt(i);
					
					if (child is ButtonPlay) {
						var bResume:ButtonResume = new buttonResume();
						
						bResume.x = child.x;
						bResume.y = child.y;
						
						visual.addChild(bResume);
						visual.removeChild(child);
						break;
					}
				}
			}
		}
		
		override public function getID():uint { return ID; }
		
		public function get isResumed():Boolean { return _isResumed; }
		
	}

}