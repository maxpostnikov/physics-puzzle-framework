package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenBack extends Screen
	{
		
		public static const ID:String = "Back";
		
		public function ScreenBack(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function getID():String { return ID; }
		
	}

}