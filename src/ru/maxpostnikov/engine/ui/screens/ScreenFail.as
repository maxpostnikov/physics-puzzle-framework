package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenFail extends Screen
	{
		
		public static const ID:String = "Fail";
		
		public function ScreenFail() 
		{
			visual = new sFail();
			
			super();
		}
		
		override public function getID():String { return ID; }
		
	}

}