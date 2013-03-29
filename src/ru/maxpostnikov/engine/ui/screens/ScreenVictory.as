package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenVictory extends Screen
	{
		
		public static const ID:String = "Victory";
		
		public function ScreenVictory(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function show(data:Object = null):void 
		{
			if (data) {
				if (data.totalScore)
					visual.tTotalScore.text = data.totalScore;
			}
		}
		
		override public function getID():String { return ID; }
		
	}

}