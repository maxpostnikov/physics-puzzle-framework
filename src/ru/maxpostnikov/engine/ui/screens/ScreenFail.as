package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenFail extends Screen
	{
		
		public static const ID:String = "Fail";
		
		public function ScreenFail(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function getID():String { return ID; }
		
	}

}