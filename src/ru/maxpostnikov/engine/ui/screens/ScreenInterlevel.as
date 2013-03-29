package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenInterlevel extends Screen
	{
		
		public static const ID:String = "Interlevel";
		
		public function ScreenInterlevel(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function show(data:Object = null):void 
		{
			if (data) {
				if (data.score)
					visual.tScore.text = data.score;
				if (data.highscore)
					visual.tHighscore.text = data.highscore;
				if (data.totalScore)
					visual.tTotalScore.text = data.totalScore;
			}
		}
		
		override public function getID():String { return ID; }
		
	}

}