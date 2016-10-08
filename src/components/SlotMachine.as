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
			
			addChild( disk1 );
			disk1.speedLimit = 30;
			
			disk2.x = 100;
			addChild( disk2 );
			disk2.speedLimit = 40;
			
			disk3.x = 200;
			addChild( disk3 );
			disk3.speedLimit = 35;
			
			timer.addEventListener( TimerEvent.TIMER, timerHandler, false, 0, true );
		}
		
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
					timer.stop();
					_areMoving = false;
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