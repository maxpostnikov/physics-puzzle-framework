package ru.maxpostnikov.utilities 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
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
		
		public static function realSize(mc:MovieClip):Point 
		{
			var rotation:Number = mc.rotation;
			
			mc.rotation = 0;
			var size:Point = new Point(mc.width, mc.height);
			mc.rotation = rotation;
			
			return size;
		}
		
	}

}