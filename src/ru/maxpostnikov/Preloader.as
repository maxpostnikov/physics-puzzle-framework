package ru.maxpostnikov
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getDefinitionByName;
	import flash.utils.Timer;
	import ru.maxpostnikov.game.GameData;
	import ru.maxpostnikov.utilities.Utils;
	
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Preloader extends MovieClip 
	{
		
		private const _LOADING_TIME_TOTAL:Number = 1.5;
		private const _LOADING_TIME_STEP:Number = 0.1;
		
		private var _visual:MovieClip;
		private var _loadingTimer:Timer;
		private var _loadedBySize:Number;
		private var _loadedByTime:Number;
		
		public function Preloader() 
		{
			if (stage) 
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			initStage();
			initContextMenu();
			
			_visual = new sPreloader();
			_visual.mcProgress.mcBar.scaleX = 0;
			_visual.buttonPlay.visible = false;
			_visual.mcSponsor.buttonMode = true;
			_visual.mcSponsor.mouseChildren = false;
			_visual.buttonPlay.addEventListener(MouseEvent.CLICK, onClickPlay, false, 0, true);
			_visual.mcSponsor.addEventListener(MouseEvent.CLICK, onClickSponsor, false, 0, true);
			
			_loadingTimer = new Timer(1000 * _LOADING_TIME_STEP, _LOADING_TIME_TOTAL / _LOADING_TIME_STEP);
			_loadingTimer.addEventListener(TimerEvent.TIMER, loadByTime, false, 0, true);
			_loadingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onLoadByTimeComplete, false, 0, true);
			_loadingTimer.start();
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, loadBySize);
			loaderInfo.addEventListener(Event.COMPLETE, onLoadBySizeComplete);
			
			addChild(_visual);
		}
		
		private function initStage():void 
		{
			stage.tabChildren = false;
			stage.stageFocusRect = false;
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function initContextMenu():void 
		{
			var context:ContextMenu = new ContextMenu();
			var moreGamesLink:ContextMenuItem = new ContextMenuItem("More Games");
			var walkthroughLink:ContextMenuItem = new ContextMenuItem("Walkthrough", true);
			
			context.hideBuiltInItems();
			context.customItems.push(moreGamesLink);
			context.customItems.push(walkthroughLink);
			
			moreGamesLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onContextMoreGames);			
			walkthroughLink.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onContextWalkthrough);
			
			this.contextMenu = context;
		}
		
		private function loadByTime(e:TimerEvent):void 
		{
			_loadedByTime = (_loadingTimer.currentCount * _LOADING_TIME_STEP) / _LOADING_TIME_TOTAL;
			
			progress();
		}
		
		private function loadBySize(e:ProgressEvent):void 
		{
			_loadedBySize = e.bytesLoaded / e.bytesTotal;
			
			progress();
		}
		
		private function onLoadByTimeComplete(e:TimerEvent):void 
		{
			_loadingTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onLoadByTimeComplete);
			_loadingTimer.removeEventListener(TimerEvent.TIMER, loadByTime);
			_loadingTimer.stop();
			_loadingTimer = null;
			
			_loadedByTime = 1;
			
			if (_loadedBySize == 1)
				complete();
		}
		
		private function onLoadBySizeComplete(e:Event):void 
		{
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadBySizeComplete);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadBySize);
			
			_loadedBySize = 1;
			
			if (_loadedByTime == 1)
				complete();
		}
		
		private function progress():void 
		{
			var value:Number = (_loadedByTime < _loadedBySize) ? _loadedByTime : _loadedBySize;
			
			_visual.mcProgress.mcBar.scaleX = value;
			_visual.mcProgress.tText.text = Math.round(value * 100);
		}
		
		private function complete():void 
		{
			_visual.buttonPlay.visible = true;
		}
		
		private function onClickPlay(e:MouseEvent):void 
		{
			if (GameData.LOCKED && !isDomainAllowed()) {
				_visual.gotoAndStop(2);
				return;
			}
			
			removeChild(_visual)
			_visual = null;
			
			startup();
		}
		
		private function isDomainAllowed():Boolean 
		{
			var domain:String;
			var protocol:Object = Utils.URL_PROTOCOL.exec(loaderInfo.loaderURL);
			if (protocol && protocol[1] == "file")
				domain = "localhost"
			
			if (!domain) {
				var url:Object = Utils.URL_PARSER.exec(loaderInfo.loaderURL);
				if (url)
					domain = url[3];
			}
			
			for each (var allowedURL:String in GameData.ALLOWED_URL) {
				if (domain && domain == allowedURL)
					return true;
			}
			
			return false;
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		private function onClickSponsor(e:MouseEvent):void 
		{
			Utils.openURL(GameData.URL_SPONSOR);
		}
		
		private function onContextMoreGames(e:ContextMenuEvent):void 
		{
			Utils.openURL(GameData.URL_MORE_GAMES);
		}
		
		private function onContextWalkthrough(e:ContextMenuEvent):void 
		{
			Utils.openURL(GameData.URL_WALKTHROUGH);
		}
		
	}
	
}