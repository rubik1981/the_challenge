package embeded 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	
	import components.slotMachine.Icon;
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
		
		
		/**
		 * the name of the image
		 */
		public static const RED_BUTTON:String = "redButton";
		
		/**
		 * the name of the image
		 */
		public static const GREEN_BUTTON:String = "greenButton";
		
		/**
		 * the name of the image
		 */
		public static const MALINA_BUTTON:String = "malinaButton";
		
		/**
		 * the name of the image
		 */
		public static const GRAY_BUTTON:String = "grayBytton";
		
		
		/**
		 * the name of the image
		 */
		public static const SOUND_ON:String = "soundOn";
		
		/**
		 * the name of the image
		 */
		public static const SOUND_OFF:String = "soundOff";
		
		
		/**
		 * the name of the sound
		 */
		public static const BIG_WIN:String = "bigWin";
		
		
		/**
		 * the name of the sound
		 */
		public static const WIN:String = "win";
		
		/**
		 * the name of the sound
		 */
		public static const NO_MONEY:String = "noMoney";
		
		/**
		 * the name of the sound
		 */
		public static const STOP:String = "stop";
		
	//-------------------------------------------------------------
	//
	//  Class Variables
	//
	//-------------------------------------------------------------	
		
		/**
		 * silent mode
		 */
		public static var mute:Boolean = false;
		
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
					
				case RED_BUTTON:
					[Embed(source = "redButton.png")]
					var redButtonClass:Class;
					bitmap = new redButtonClass() as Bitmap;
					break;
					
				case GREEN_BUTTON:
					[Embed(source = "greenButton.png")]
					var greenButtonClass:Class;
					bitmap = new greenButtonClass() as Bitmap;
					break;
					
				case GRAY_BUTTON:
					[Embed(source = "grayButton.png")]
					var grayButtonClass:Class;
					bitmap = new grayButtonClass() as Bitmap;
					break;
					
				case MALINA_BUTTON:
					[Embed(source = "malinaButton.png")]
					var malinaButtonClass:Class;
					bitmap = new malinaButtonClass() as Bitmap;
					break;
					
				case SOUND_OFF:
					[Embed(source = "soundOff.png")]
					var soundOffClass:Class;
					bitmap = new soundOffClass() as Bitmap;
					break;
					
				case SOUND_ON:
					[Embed(source = "soundOn.png")]
					var soundOnClass:Class;
					bitmap = new soundOnClass() as Bitmap;
					break;
					
			}
			
			var icon:Icon = new Icon();
			icon.bitmap.bitmapData = bitmap.bitmapData.clone();
			icon.type = name;
			
			return icon;		
		}
		
		/**
		 * returns the embeded sound
		 * @param	name	use name of the sound constants here
		 * @return
		 */
		public static function playSound( name:String ) : void
		{
			if ( true == mute )
			{
				return;
			}
			
			var sound:Sound;
			
			switch ( name )
			{
				case BIG_WIN:
					[Embed(source = "bigWin.mp3")]
					var bigWinClass:Class;
					sound = new bigWinClass() as Sound;
					break;
					
				
				case WIN:
					[Embed(source = "win.mp3")]
					var winClass:Class;
					sound = new winClass() as Sound;
					break;
					
					
				case NO_MONEY:
					[Embed(source = "noMoney.mp3")]
					var noMoneyClass:Class;
					sound = new noMoneyClass() as Sound;
					break;
					
					
				case STOP:
					[Embed(source = "stop.mp3")]
					var stopClass:Class;
					sound = new stopClass() as Sound;
					break;
					
			}
			
			sound.play();			
		}
		
	}

}