package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenCredits extends Screen
	{
		
		public static const ID:uint = 5;
		
		public function ScreenCredits() 
		{
			visual = new sCredits();
			
			super();
		}
		
		override public function getID():uint { return ID; }
		
	}

}