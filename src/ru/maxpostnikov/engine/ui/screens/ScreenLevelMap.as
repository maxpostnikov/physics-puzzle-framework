package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.buttons.ButtonLevel;
	import ru.maxpostnikov.game.GameData;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenLevelMap extends Screen
	{
		
		public static const ID:uint = 4;
		
		private static const _BUTTON_OFFSET:int = 10;
		
		private var _buttonsLevel:Vector.<ButtonLevel>;
		
		public function ScreenLevelMap() 
		{
			visual = new sLevelMap();
			
			createButtonsLevel();
			
			super();
		}
		
		override public function show(data:Object = null):void 
		{
			setButtonsState();
		}
		
		private function createButtonsLevel():void 
		{
			_buttonsLevel = new <ButtonLevel>[];
			
			var buttonX:int = 0;
			var buttonY:int = 0;
			for (var i:int = 0; i < GameData.LEVELS_TOTAL; i++) {
				var button:ButtonLevel = new bLevel();
				
				button.level = i + 1;
				(button as MovieClip).tText.text = button.level;
				
				var position:Point = visual.mcHolder.localToGlobal(new Point(buttonX + button.width / 2, 
																		   buttonY + button.height / 2));
				button.x = position.x;
				button.y = position.y;
				
				visual.addChild(button);
				_buttonsLevel.push(button);
				
				buttonX += button.width + _BUTTON_OFFSET;
				if (buttonX > visual.mcHolder.width) {
					buttonX = 0;
					buttonY += button.height + _BUTTON_OFFSET;
					if (buttonY > visual.mcHolder.height) {
						buttonY = 0;
						break;
					}
				}
			}
		}
		
		private function setButtonsState():void 
		{
			for (var i:int = 0; i < _buttonsLevel.length; i++) {
				var button:ButtonLevel = _buttonsLevel[i]
				
				if (i > 0 && Engine.getInstacne().isLevelClosed(button.level)) {
					button.gotoAndStop(2);
					button.isClosed = true;
				} else {
					button.gotoAndStop(1);
					button.isClosed = false;
				}
			}
		}
		
		override public function getID():uint { return ID; }
		
	}

}