package ru.maxpostnikov.engine.ui.screens 
{
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenHUD extends Screen
	{
		
		public static const ID:uint = 7;
		
		public function ScreenHUD() 
		{
			visual = new sHUD();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			update(data);
		}
		
		override public function update(data:Object):void 
		{
			if (data) {
				if (data.level)
					visual.mcLevelData.tLevel.text = data.level;
				if (data.score)
					visual.mcLevelData.tScore.text = data.score;
			}
		}
		
		override public function getID():uint { return ID; }
		
	}

}