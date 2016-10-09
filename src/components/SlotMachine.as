package components 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	
	import components.Disk;
	import events.SlotEvent;
	
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
			disk3.addEventListener( SlotEvent.DISK_WAS_STOPPED, disk3WasStoppedHandler, false, 0, true );
			disk3.addEventListener( SlotEvent.DISK_WAS_STARTED, disk3WasStartedHandler, false, 0, true );
			addChild( disk3 );
			
			timerNextDisk.addEventListener( TimerEvent.TIMER, timerHandler, false, 0, true );
			autoStopTimer.addEventListener( TimerEvent.TIMER, autoStopTimerHandler, false, 0, true );
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
		
		protected var disk1:Disk = new Disk();
		protected var disk2:Disk = new Disk();
		protected var disk3:Disk = new Disk();
		
		private var nextDisk:Disk = null;
		private var timerNextDisk:Timer = new Timer( 250 );
		private var autoStopTimer:Timer = new Timer( 5000 );
		
		private var _areMoving:Boolean = false;
		
		protected var readyToStart:Boolean = true;
		protected var readyToStop:Boolean = false;
		
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
			if ( true == readyToStart )
			{
				readyToStart = false;
				disk1.go();
				nextDisk = disk2;
				timerNextDisk.start();
				autoStopTimer.start();
			}
		}
		
		/**
		 * stops the rotation of disks
		 */
		public function stop() : void
		{			
			if ( true == readyToStop )
			{
				readyToStop = false;
				autoStopTimer.stop();
				disk1.stop();
				nextDisk = disk2;
				timerNextDisk.start();
			}
		}
		
		private function afterStart() : void
		{
			timerNextDisk.stop();
			_areMoving = true;
			readyToStop = true;
		}
		
		private function afterStop() : void
		{
			timerNextDisk.stop();
			_areMoving = false;
			readyToStart = true;
			dispatchEvent( new SlotEvent(SlotEvent.DISKS_WERE_STOPPED) );
		}
	
	//-------------------------------------------------------------
	//
	//  Event Listeners
	//
	//-------------------------------------------------------------	
		
	
		private function autoStopTimerHandler( event:TimerEvent ) : void
		{
			stop();
		}
	
		private function disk3WasStoppedHandler( event:SlotEvent ) : void
		{
			afterStop();
		}
		
		private function disk3WasStartedHandler( event:SlotEvent ) : void
		{
			afterStart();
		}
	
		private function timerHandler( event:TimerEvent ) : void
		{
			if ( false == areMoving )
			{
				if ( disk3 == nextDisk )
				{
					disk3.go();
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