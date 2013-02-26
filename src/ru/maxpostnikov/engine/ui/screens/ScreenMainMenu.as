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
		private var _buttonPlay:ButtonPlay;
		private var _buttonResume:ButtonResume;
		
		public function ScreenMainMenu() 
		{
			visual = new sMainMenu();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			super.show(data);
			
			if (data)
				_isResumed = data.isResumed;
			
			if (_isResumed) {
				if (!_buttonResume) {
					for (var i:int = 0; i < visual.numChildren; i++) {
						var child:DisplayObject = visual.getChildAt(i);
						
						if (child is ButtonPlay) {
							_buttonPlay = child as ButtonPlay;
							_buttonResume = new bResume();
							
							_buttonResume.x = child.x;
							_buttonResume.y = child.y;
							
							visual.addChild(_buttonResume);
							break;
						}
					}
				}
				
				if (_buttonPlay && _buttonResume) {
					_buttonPlay.visible = false;
					_buttonResume.visible = true;
				}
			} else {
				if (_buttonPlay && _buttonResume) {
					_buttonPlay.visible = true;
					_buttonResume.visible = false;
				}
			}
		}
		
		override public function getID():uint { return ID; }
		
		public function get isResumed():Boolean { return _isResumed; }
		
	}

}