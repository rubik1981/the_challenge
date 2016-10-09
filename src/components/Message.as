package components 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import embeded.Embeded;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class Message extends Sprite 
	{

	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function Message() 
		{
			super();
			
			graphics.beginFill( 0xC0C0C0, 0.1 );
			graphics.drawRect( 0, 0, 800, 600 );
			
			graphics.beginFill( 0x0000FF );
			graphics.lineStyle( 2, 0x80FF00 );
			graphics.drawRect( 100, 250, 600, 100 );
			graphics.endFill();
			
			tf.text = "You do not have enough money!";
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.setTextFormat( new TextFormat( null, 40, 0xFF5E5E, true ) );
			tf.x = width - tf.width; tf.x /= 2;
			tf.y = height - tf.height; tf.y /= 2;
			addChild( tf );
			
			timer.addEventListener( TimerEvent.TIMER, timerHandler, false, 0, true );
			timer.start();
			
			Embeded.playSound( Embeded.NO_MONEY );
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		private var timer:Timer = new Timer( 500 );
		private var blinkQty:int = 0;
		private var tf:TextField = new TextField();

	//-------------------------------------------------------------
	//
	//  Event Listeneres
	//
	//-------------------------------------------------------------	
		
		private function timerHandler( event:TimerEvent ) : void
		{
			if ( null == tf.parent )
			{
				addChild( tf );
			}
			else
			{
				removeChild( tf );
			}
			
			blinkQty++;
			
			if ( 8 == blinkQty )
			{
				timer.stop();
				parent.removeChild( this );
			}
		}
	
	}

}