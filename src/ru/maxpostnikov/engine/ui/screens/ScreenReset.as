package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenReset extends Screen
	{
		
		public static const ID:String = "Reset";
		
		public function ScreenReset() 
		{
			visual = new sReset();
			
			super();
		}
		
		override public function getID():String { return ID; }
		
	}

}