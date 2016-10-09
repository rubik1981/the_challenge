package components.slotMachine 
{
	import components.slotMachine.Icon;
	import components.slotMachine.SlotMachine;
	import embeded.Embeded;
	import events.SlotEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * SlotMachine with Win Logic
	 * @author rubik
	 */
	public class SlotMachineWL extends SlotMachine 
	{

	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function SlotMachineWL() 
		{
			super();
			
			addEventListener( SlotEvent.DISKS_WERE_STOPPED, disksWereStoppedHandler, false, 0, true );
			
			timerFinish.addEventListener( TimerEvent.TIMER, timerFinishHandler, false, 0, true );
			timerMarkEach.addEventListener( TimerEvent.TIMER, timerMarkEachHandler, false, 0, true );
			timerMarkNext.addEventListener( TimerEvent.TIMER, timerMakrNextHandler, false, 0, true );
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		private var winLines:Array/* of Array of Icon */;
		private var timerFinish:Timer = new Timer( 2000 );
		private var timerMarkEach:Timer = new Timer( 1000 );
		private var timerMarkNext:Timer = new Timer( 750 );
		private var lastLine:int;
		
		
	//-------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------	
	
		/**
		 * quantity of win lines
		 */
		public function get winLineQty() : int
		{
			return winLines.length;
		}
	
	//-------------------------------------------------------------
	//
	//  Methods
	//
	//-------------------------------------------------------------
	
		/**
		 * search for win lines
		 * and mark it
		 */
		public function findWinLines() : void
		{
			winLines = [];
			
			checkLine( 0, 0, 0 );
			checkLine( 1, 1, 1 );
			checkLine( 2, 2, 2 );
			checkLine( 0, 1, 2 );
			checkLine( 2, 1, 0 );
			
			if ( 0 < winLineQty )
			{
				markAll(true);
				if ( 1 == winLineQty )
				{
					timerFinish.start();
				}
				else
				{
					timerMarkEach.start();
				}
			}
			else
			{
				finish();
			}
			
			dispatchEvent( new SlotEvent(SlotEvent.WIN_LINES_ARE_CHECKED) );
			
			if ( 1 == winLineQty )
			{
				Embeded.playSound( Embeded.WIN );
			}
			
			if ( 1 < winLineQty )
			{
				Embeded.playSound( Embeded.BIG_WIN );
			}
		}
		
		private function checkLine( i1:int, i2:int, i3:int ) : void
		{
			var icon1:Icon = Icon( disk1.results[i1] );
			var icon2:Icon = Icon( disk2.results[i2] );
			var icon3:Icon = Icon( disk3.results[i3] );
			
			if ( icon1.type == icon2.type && icon2.type == icon3.type )
			{
				winLines.push( [ icon1, icon2, icon3 ] );
			}
		}
		
		private function finish() : void
		{
			readyToStart = true;
			dispatchEvent( new SlotEvent(SlotEvent.MACHINE_IS_READY_TO_START) );
		}
		
		private function markAll( blink:Boolean ) : void
		{
			for ( var i:int = 0; i < winLines.length; i++ )
			{
				var line:Array/* of Icon */ = winLines[i];
				for each ( var icon:Icon in line )
				{
					icon.blink = blink;
				}
			}
		}
		
		private function markLine( index:int, blink:Boolean ) : void
		{
			if ( -1 < index )
			{
				var line:Array = winLines[ index ];
				for each ( var icon:Icon in line )
				{
					icon.blink = blink;
				}
			}
		}
		
	//-------------------------------------------------------------
	//
	//  Event Listeners
	//
	//-------------------------------------------------------------	
		
		private function disksWereStoppedHandler( event:SlotEvent ) : void
		{
			findWinLines();
		}
		
		private function timerFinishHandler( event:TimerEvent ) : void
		{
			timerFinish.stop();
			markAll( false );
			finish();
		}
	
		private function timerMarkEachHandler( event:TimerEvent ) : void
		{
			timerMarkEach.stop();
			markAll( false );
			lastLine = -1;
			timerMarkNext.start();
		}
		
		private function timerMakrNextHandler( event:TimerEvent ) : void
		{
			markLine( lastLine, false );
			lastLine++;
			if ( winLineQty > lastLine )
			{
				markLine( lastLine, true );
			}
			else
			{
				timerMarkNext.stop();
				finish();
			}
		}
		
	}

}