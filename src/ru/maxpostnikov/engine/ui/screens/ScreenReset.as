package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenReset extends Screen
	{
		
		public static const ID:String = "Reset";
		
		public function ScreenReset(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function getID():String { return ID; }
		
	}

}