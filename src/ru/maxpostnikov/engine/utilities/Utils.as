package ru.maxpostnikov.engine.utilities 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Utils 
	{
		
		//0 - url, 1 - protocol, 2 - www. if exists, 3 - domain without www., 4 - query string after domain
		public static const URL_PARSER:RegExp = /([\w]+):\/\/(www\.)?([\w-\.]+\.?\w+\.\w+)(.*)/i;
		public static const URL_PROTOCOL:RegExp = /([\w]+):\/\//i;
		
		public static function randomNumber(min:Number, max:Number, round:Number = 1):Number 
		{
			var delta:Number = (max - min) + (1 * round);
			var random:Number = Math.random() * delta;
			random += min;
			
			return Math.floor(random / round) * round;
		}
		
		public static function angleInDegrees(angle:Number):Number 
		{
			return angle * 180 / Math.PI;
		}
		
		public static function angleInRadians(angle:Number):Number 
		{
			return angle * Math.PI / 180;
		}
		
		public static function rotateInsideOut(container:DisplayObjectContainer):void 
		{
			var rotation:Number = container.rotation;
			var angle:Number = angleInRadians(rotation);
			
			for (var i:int = 0; i < container.numChildren; i++) {
				var child:DisplayObject = container.getChildAt(i);
				var position:Point = new Point((Math.cos(angle) * child.x) - (Math.sin(angle) * child.y),
											   (Math.sin(angle) * child.x) + (Math.cos(angle) * child.y));
				
				child.x = position.x;
				child.y = position.y;
				child.rotation += rotation;
			}
			
			container.rotation = 0;
		}
		
		public static function transmitPosition(container:DisplayObjectContainer):void 
		{
			for (var i:int = 0; i < container.numChildren; i++) {
				var child:DisplayObject = container.getChildAt(i);
				
				child.x += container.x;
				child.y += container.y;
			}
			
			container.x = container.y = 0;
		}
		
		public static function realSize(mc:MovieClip):Rectangle 
		{
			var rotation:Number = mc.rotation;
			
			mc.rotation = 0;
			var size:Rectangle = new Rectangle(0, 0, mc.width, mc.height);
			mc.rotation = rotation;
			
			return size;
		}
		
		public static function stopChildsOf(clip:MovieClip, self:Boolean = false):void 
		{
			if (self) clip.stop();
			
			for (var i:int = 0; i < clip.numChildren; i++) {
				var child:DisplayObject = clip.getChildAt(i);
				
				if (child is MovieClip) stopChildsOf(child as MovieClip, true);
			}
		}
		
		public static function playChildsOf(clip:MovieClip, self:Boolean = true):void 
		{
			if (self) clip.play();
			
			for (var i:int = 0; i < clip.numChildren; i++) {
				var child:DisplayObject = clip.getChildAt(i);
				
				if (child is MovieClip) playChildsOf(child as MovieClip, true);
			}
		}
		
		public static function getDefinition(name:String):Object 
		{
			var object:Object;
			
			try {
				object = getDefinitionByName(name);
			} catch (e:Error) {
				trace("get definition error " + e.message);
			} finally {
				return object;
			}
		}
		
		public static function openURL(url:String, window:String = "_blank"):void 
		{
			navigateToURL(new URLRequest(url), window);
		}
		
	}

}