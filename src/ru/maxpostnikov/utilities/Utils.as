package ru.maxpostnikov.utilities 
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
		
		public static function realSize(mc:MovieClip):Rectangle 
		{
			var rotation:Number = mc.rotation;
			
			mc.rotation = 0;
			var size:Rectangle = new Rectangle(0, 0, mc.width, mc.height);
			mc.rotation = rotation;
			
			return size;
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