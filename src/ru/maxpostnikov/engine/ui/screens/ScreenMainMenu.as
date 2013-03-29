package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
		
		public function ScreenMainMenu(visual:MovieClip) 
		{
			super(visual);
			
			initButtonsPlayResume();
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
				} else if (child is ButtonResume) {
					_buttonResume = child as ButtonResume;
					_buttonResume.visible = false;
				}
			}
		}
		
		override public function getID():String { return ID; }
		
		public function get isResumed():Boolean { return _isResumed; }
		
	}

}