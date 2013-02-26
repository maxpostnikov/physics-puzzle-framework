package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenReset extends Screen
	{
		
		public static const ID:uint = 4;
		
		public function ScreenReset() 
		{
			visual = new sReset();
			
			super();
		}
		
		override public function getID():uint { return ID; }
		
	}

}