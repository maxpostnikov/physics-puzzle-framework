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
		
		public static const ID:String = "MainMenu";
		
		private var _isResumed:Boolean;
		private var _buttonPlay:ButtonPlay;
		private var _buttonResume:ButtonResume;
		
		public function ScreenMainMenu() 
		{
			visual = new sMainMenu();
			
			initButtonsPlayResume();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			update(data);
			
			if (_buttonPlay && _buttonResume) {
				if (_isResumed) {
					_buttonPlay.visible = false;
					_buttonResume.visible = true;
				} else {
					_buttonPlay.visible = true;
					_buttonResume.visible = false;
				}
			}
		}
		
		override public function update(data:Object):void 
		{
			if (data) _isResumed = data.isResumed;
		}
		
		private function initButtonsPlayResume():void 
		{
			for (var i:int = 0; i < visual.numChildren; i++) {
				var child:DisplayObject = visual.getChildAt(i);
				
				if (child is ButtonPlay) {
					_buttonPlay = child as ButtonPlay;
					_buttonResume = new bResume();
					
					_buttonResume.x = child.x;
					_buttonResume.y = child.y;
					_buttonResume.scaleX = child.scaleX;
					_buttonResume.scaleY = child.scaleY;
					_buttonResume.visible = false;
					
					visual.addChild(_buttonResume);
					break;
				}
			}
		}
		
		override public function getID():String { return ID; }
		
		public function get isResumed():Boolean { return _isResumed; }
		
	}

}