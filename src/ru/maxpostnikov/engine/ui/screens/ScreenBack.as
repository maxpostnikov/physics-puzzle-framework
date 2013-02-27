package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenBack extends Screen
	{
		
		public static const ID:uint = 1;
		
		public function ScreenBack() 
		{
			visual = new sBack();
			
			super();
		}
		
		override public function getID():uint { return ID; }
		
	}

}