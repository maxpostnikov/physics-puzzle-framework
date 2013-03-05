package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenVictory extends Screen
	{
		
		public static const ID:String = "Victory";
		
		public function ScreenVictory() 
		{
			visual = new sVictory();
			
			super();
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