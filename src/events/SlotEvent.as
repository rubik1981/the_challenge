package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class SlotEvent extends Event 
	{
		
	//-------------------------------------------------------------
	//
	//  Class Constants
	//
	//-------------------------------------------------------------	
		
		/**
		 * all disks of slot_machine were stopped
		 */
		public static const DISKS_WERE_STOPPED:String = "disksWereStopped";
		
		/**
		 * the disk was stopped
		 */
		public static const DISK_WAS_STOPPED:String = "diskWasStopped";
		
		/**
		 * machine is ready for new rotation
		 */
		public static const MACHINE_IS_READY_TO_START:String = "machineIsReadyToStart";
		
		/**
		 * after checking the win lines
		 */
		public static const WIN_LINES_ARE_CHECKED:String = "winLinesAreChecked";
		
		/**
		 * when starting process is complete
		 */
		public static const DISK_WAS_STARTED:String = "diskWasStarted";
		
		/**
		 * after all disks were started
		 */
		public static const DISKS_WERE_STARTED:String = "disksWereStarted";
	
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function SlotEvent(type:String) 
		{
			super(type);
			
		}
		
	}

}