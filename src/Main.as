package
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import screens.PrimaryScreen;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class Main extends Sprite 
	{
	
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	//-------------------------------------------------------------
	//
	//  Event Listeneres
	//
	//-------------------------------------------------------------	
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
				
			addChild( new PrimaryScreen() );
		}
		
	}
	
}