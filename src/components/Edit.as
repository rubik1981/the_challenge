package components 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class Edit extends Sprite 
	{
		
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function Edit( caption:String ) 
		{
			super();
			
			tfCaption.text = caption;
			tfCaption.autoSize = TextFieldAutoSize.LEFT;
			tfCaption.setTextFormat( new TextFormat( null, 30, 0x00FF00, true ) );
			addChild( tfCaption );
		
			tfValue.width = 100;
			tfValue.height = 36;
			tfValue.x = 130;
			tfValue.background = true;
			tfValue.backgroundColor = 0x0080C0;
			tfValue.border = true;
			tfValue.borderColor = 0x800080;

			addChild( tfValue );
			
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		private var tfCaption:TextField = new TextField();
		private var tfValue:TextField = new TextField();
		
		private var _value:int = 0;
		
	//-------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------	
		
		/**
		 * the value of this field
		 */
		public function get value() : int
		{
			return _value;
		}
		
		public function set value( value:int ) : void
		{
			_value = value;
			tfValue.text = " " + value.toString();
			tfValue.setTextFormat( new TextFormat( null, 30, 0xFFFF00 ) );
		}
	
	}

}