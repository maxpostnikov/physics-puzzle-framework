package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenBack extends Screen
	{
		
		public static const ID:String = "Back";
		
		public function ScreenBack() 
		{
			visual = new sBack();
			
			super();
		}
		
		override public function getID():String { return ID; }
		
	}

}