package embeded 
{
	import components.Icon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author rubik
	 */
	public class Embeded 
	{

	//-------------------------------------------------------------
	//
	//  Class Constants
	//
	//-------------------------------------------------------------	
		
		/**
		 * the name of the image
		 */
		public static const TEN:String = "ten";
		
		/**
		 * the name of the image
		 */
		public static const A:String = "a";
		
		/**
		 * the name of the image
		 */
		public static const J:String = "j";
		
		/**
		 * the name of the image
		 */
		public static const K:String = "k";
		
		/**
		 * the name of the image
		 */
		public static const Q:String = "q";
		
		/**
		 * the name of the image
		 */
		public static const BACKGROUND:String = "background";
		
	//-------------------------------------------------------------
	//
	//  Class Methods
	//
	//-------------------------------------------------------------	
		
		/**
		 * returns the embeded image
		 * @param	name	use name of the image constants here
		 * @return
		 */
		public static function getImage( name:String ) : Icon
		{
			var bitmap:Bitmap;
			
			switch ( name )
			{
				case A:
					[Embed(source = "a.png")]
					var aClass:Class;
					bitmap = new aClass() as Bitmap;
					break;
			
				case J:
					[Embed(source = "j.png")]
					var jClass:Class;
					bitmap = new jClass() as Bitmap;
					break;
					
					
				case K:
					[Embed(source = "k.png")]
					var kClass:Class;
					bitmap = new kClass() as Bitmap;
					break;
					
					
				case Q:
					[Embed(source = "q.png")]
					var qClass:Class;
					bitmap = new qClass() as Bitmap;
					break;
					
					
				case TEN:
					[Embed(source = "ten.png")]
					var tenClass:Class;
					bitmap = new tenClass() as Bitmap;
					break;
					
				case BACKGROUND:
					[Embed(source = "background.png")]
					var backgroundClass:Class;
					bitmap = new backgroundClass() as Bitmap;
					break;
					
			}
			
			var icon:Icon = new Icon();
			icon.bitmap.bitmapData = bitmap.bitmapData.clone();
			icon.type = name;
			
			return icon;		
		}
		
		
	}

}