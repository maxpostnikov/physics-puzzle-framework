package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenCredits extends Screen
	{
		
		public static const ID:String = "Credits";
		
		public function ScreenCredits(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function getID():String { return ID; }
		
	}

}