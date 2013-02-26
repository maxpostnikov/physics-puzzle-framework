package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenCredits extends Screen
	{
		
		public static const ID:uint = 3;
		
		private var _isResumed:Boolean;
		
		public function ScreenCredits() 
		{
			visual = new sCredits();
			
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