package components 
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	

	import embeded.Embeded;
	import components.slotMachine.Icon;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class Button extends SimpleButton 
	{

	//-------------------------------------------------------------
	//
	//  Class Variables
	//
	//-------------------------------------------------------------	
		
		private static var caption:String;
		private static var isRed:Boolean;
	
	//-------------------------------------------------------------
	//
	//  Class Methods
	//
	//-------------------------------------------------------------	
		
		private static function createState( stateName:String ) : Icon
		{
			var icon:Icon = Embeded.getImage( stateName );
			
			var tf:TextField = new TextField();
			tf.text = caption;
			tf.autoSize = TextFieldAutoSize.CENTER;
			if ( false == isRed )
			{
				var color:uint = 0xFFFF00;
			}
			else
			{
				color = 0xFFFF00;
			}
			tf.setTextFormat( new TextFormat(null, 40, color, true) );
			
			tf.x = icon.width - tf.width;
			tf.x /= 2;
			
			tf.y = icon.height - tf.height;
			tf.y /= 2;
			
			icon.addChild( tf );
			
			return icon;
		}
		
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function Button( caption:String, isRed:Boolean = false ) 
		{
			Button.caption = caption;
			Button.isRed = isRed;
			
			var upStateName:String;
			if ( true == isRed )
			{
				upStateName = Embeded.RED_BUTTON;
			}
			else
			{
				upStateName = Embeded.GRAY_BUTTON;
			}
			
			super(
				createState( upStateName ),
				createState( upStateName ),
				createState( Embeded.MALINA_BUTTON),
				createState( Embeded.GREEN_BUTTON )
				);
			
		}
		
	}

}