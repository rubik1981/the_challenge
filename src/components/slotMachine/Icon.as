package components.slotMachine 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class Icon extends Sprite 
	{
		
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function Icon() 
		{
			super();
			
			addChild( bitmap );
			
			blinkTimer.addEventListener( TimerEvent.TIMER, blinkTimerHandler, false, 0, true );
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		/**
		 * name of the type of this image
		 */
		public var type:String;
		
		/**
		 * the image
		 */
		public var bitmap:Bitmap = new Bitmap();
		
		private var _blink:Boolean = false;
		private var blinkTimer:Timer = new Timer( 250 );
		private var savedParent:Sprite;
		
	//-------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------	

		/**
		 * blink state
		 */
		public function get blink() : Boolean
		{
			return _blink;
		}
		
		public function set blink( value:Boolean ) : void
		{
			_blink = value;
			
			if ( true == blink )
			{
				blinkTimer.start();
			}
			else
			{
				blinkTimer.stop();
				if ( null == parent )
				{
					savedParent.addChild( this );
				}
			}
		}
	
	//-------------------------------------------------------------
	//
	//  Event Listeners
	//
	//-------------------------------------------------------------	
		
		private function blinkTimerHandler( event:TimerEvent ) : void
		{
			if ( null == savedParent )
			{
				savedParent = parent as Sprite;
			}
			
			if ( null == parent )
			{
				savedParent.addChild( this );
			}
			else
			{
				parent.removeChild( this );
			}
			
		}
	
	
	}

}