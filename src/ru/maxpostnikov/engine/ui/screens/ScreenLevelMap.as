package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenLevelMap extends Screen
	{
		
		public static const ID:uint = 2;
		
		private var _isResumed:Boolean;
		
		public function ScreenLevelMap() 
		{
			visual = new levelMap();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			super.show(data);
			
			_isResumed = data.isResumed;
		}
		
		override public function getID():uint { return ID; }
		
		public function get isResumed():Boolean { return _isResumed; }
		
	}

}