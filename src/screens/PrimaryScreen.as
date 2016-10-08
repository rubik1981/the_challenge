package screens 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import components.Icon;
	import components.SlotMachine;
	import embeded.Embeded;
	
	/**
	 * the first screen of this app
	 * @author rubik
	 */
	public class PrimaryScreen extends Sprite 
	{
	
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function PrimaryScreen() 
		{
			super();
			
			disks.x = 100;
			disks.y = 100;
			addChild( disks );
			
			var background:Bitmap = Embeded.getImage( Embeded.BACKGROUND ).bitmap;
			addChild( background );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		private var disks:SlotMachine = new SlotMachine();
			
	//-------------------------------------------------------------
	//
	//  Event Listeners
	//
	//-------------------------------------------------------------	
		
		private function addedToStageHandler( event:Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			stage.addEventListener( KeyboardEvent.KEY_UP, stageKeyUpHandler, false, 0, true );
		}
		
		private function stageKeyUpHandler( event:KeyboardEvent ) : void
		{
			if ( Keyboard.SPACE == event.keyCode )
			{
				if ( false == disks.areMoving )
				{
					disks.go();
				}
				else
				{
					disks.stop();
				}
			}
		}
	
	}

}