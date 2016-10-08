package components 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	
	import components.Disk;
	
	/**
	 * just three disks together
	 * @author rubik
	 */
	public class SlotMachine extends Sprite 
	{

	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function SlotMachine() 
		{
			super();
			
			disk1.speedLimit = 30;
			addChild( disk1 );
			
			disk2.x = 100;
			disk2.speedLimit = 40;
			addChild( disk2 );
			
			disk3.x = 200;
			disk3.speedLimit = 35;
			addChild( disk3 );
			
			timer.addEventListener( TimerEvent.TIMER, timerHandler, false, 0, true );
		}
		
	//-------------------------------------------------------------
	//
	//  Constants
	//
	//-------------------------------------------------------------	
		
		private const WIN_LINE_1:Array/* of int */ = [ 0, 0, 0 ];
		private const WIN_LINE_2:Array/* of int */ = [ 1, 1, 1 ];
		private const WIN_LINE_3:Array/* of int */ = [ 2, 2, 2 ];
		private const WIN_LINE_4:Array/* of int */ = [ 0, 1, 2 ];
		private const WIN_LINE_5:Array/* of int */ = [ 2, 1, 0 ];
	
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		private var disk1:Disk = new Disk();
		private var disk2:Disk = new Disk();
		private var disk3:Disk = new Disk();
		
		private var nextDisk:Disk = null;
		private var timer:Timer = new Timer( 250 );
		
		private var _winCount:int = 0;
		private var _areMoving:Boolean = false;
		
	//-------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------
	
		/**
		 * are disks moving or not
		 */
		public function get areMoving() : Boolean
		{
			return _areMoving;
		}
	
		/**
		 * how much are lines win?
		 */
		public function get winCount() : int
		{
			return _winCount;
		}
		
	//-------------------------------------------------------------
	//
	//  Methods
	//
	//-------------------------------------------------------------	
		
		/**
		 * begins the rotation of disks
		 */
		public function go() : void
		{
			if ( false == timer.running )
			{
				disk1.go();
				nextDisk = disk2;
				timer.start();
			}
		}
		
		/**
		 * stops the rotation of disks
		 */
		public function stop() : void
		{
			if ( false == timer.running )
			{
				disk1.stop();
				nextDisk = disk2;
				timer.start();
			}
		}
		
		private function afterStop() : void
		{
			timer.stop();
			_areMoving = false;
			
			_winCount = 0;
			checkWinLine( WIN_LINE_1 );
			checkWinLine( WIN_LINE_2 );
			checkWinLine( WIN_LINE_3 );
			checkWinLine( WIN_LINE_4 );
			checkWinLine( WIN_LINE_5 );
		}
		
		private function checkWinLine( line:Array/* of int */ ) : void
		{
			return;
			var icon1:Icon = disk1.results[ line[0] ];
			var icon2:Icon = disk2.results[ line[1] ];
			var icon3:Icon = disk3.results[ line[2] ];
			if ( icon1.type == icon2.type && icon2.type == icon3.type )
			{
				_winCount++;
				icon1.blink = true;
				icon2.blink = true;
				icon3.blink = true;
			}
			
		}
	
	//-------------------------------------------------------------
	//
	//  Event Listeners
	//
	//-------------------------------------------------------------	
		
	
		private function timerHandler( event:TimerEvent ) : void
		{
			if ( false == areMoving )
			{
				if ( disk3 == nextDisk )
				{
					disk3.go();
					timer.stop();
					_areMoving = true;
				}
				
				if ( disk2 == nextDisk )
				{
					disk2.go();
					nextDisk = disk3;
				}
			}
			else
			{
				if ( disk3 == nextDisk )
				{
					disk3.stop();
					afterStop();
				}
				
				if ( disk2 == nextDisk )
				{
					disk2.stop();
					nextDisk = disk3;
				}
			}
		}
	
	}

}