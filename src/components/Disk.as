package components 
{
	import events.SlotEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import Math;
	
	import embeded.Embeded;
	
	/**
	 * ...
	 * @author rubik
	 */
	public class Disk extends Sprite 
	{
		
	//-------------------------------------------------------------
	//
	//  Class Constants
	//
	//-------------------------------------------------------------	
		
		private static const WIDTH:int = 100;
		private static const HEIGHT:int = 300;
		
		//--------------------------
		// ↓ disks state ↓
		//--------------------------
		private static const STAY_STILL:String = "stayStill";
		private static const BEGIN_MOVEMENT:String = "beginMovement";
		private static const IN_MOTION:String = "inMotion";
		private static const SLOWS_DOWN:String = "slowsDown";
		private static const SHAKES:String = "shakes";
		
	
	//-------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------	
		
		public function Disk() 
		{
			super();
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( WIDTH, HEIGHT, Math.PI/2, 0, 0 );
			
			graphics.beginGradientFill( GradientType.LINEAR, [0x0080FF, 0x79BCFF, 0x0080FF], [1, 1, 1], [0, 128, 255], matrix );
			graphics.drawRect( 0, 0, WIDTH, HEIGHT );
			graphics.endFill();
			
			graphics.lineStyle( 2, 0x0000A0 );
			graphics.moveTo( WIDTH, 0 );
			graphics.lineTo( WIDTH, HEIGHT );
			
			addChild( ten );
			addChild( k );
			addChild( a );
			addChild( j );
			addChild( q );
			
			fillSlots();
			
			addEventListener( Event.ENTER_FRAME, enterFrameHandler, false, 0, true );
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
	
		/**
		 * maximum of the speed
		 */
		public var speedLimit:int = 40;
	
		
		
		private var _state:String = STAY_STILL;
		private var _position:int = 0;
		private var _results:Array/* of Icon */ = [ null, null, null ];

		private var acceleration:Number = 0;

		private var a:Icon = Embeded.getImage( Embeded.A );
		private var j:Icon = Embeded.getImage( Embeded.J ); 
		private var k:Icon = Embeded.getImage( Embeded.K );
		private var ten:Icon = Embeded.getImage( Embeded.TEN );
		private var q:Icon = Embeded.getImage( Embeded.Q );
		
		private var speed:Number = 0;
		private var slots:Array/* of Icon */ = [ null, null, null, null, null ];
		
	//-------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------	
		
		/**
		 * rotation position of the disk
		 */
		private function get position() : int
		{
			return _position;
		}
		
		private function set position( value:int ) : void
		{
			_position = value;
			
			const SIZE:int = WIDTH * 5;
			
			if ( SIZE < position )
			{
				_position -= SIZE;
			}
			
			if ( 0 > position )
			{
				_position += SIZE;
			}
			
			for ( var i:int = 0; i < slots.length; i++ )
			{
				var newY:int = i * WIDTH + position;
				if ( (SIZE - WIDTH) < newY )
				{
					newY -= SIZE;
				}
				
				slots[i].y = newY;
			}
		}
		
		/**
		 * the current items
		 * @return
		 */
		public function get results() : Array/* of String */
		{
			return _results;
		}
		
		/**
		 * current movement state of the disk
		 */
		private function get state() : String 
		{
			return _state;
		}
		
		private function set state( value:String ) : void
		{
			_state = value;
			
			switch ( state )
			{
				case STAY_STILL:
					acceleration = 0;
					speed = 0;
					break;
				
				case BEGIN_MOVEMENT:
					acceleration = 1;
					break;
					
				case IN_MOTION:
					acceleration = 0;
					dispatchEvent( new SlotEvent(SlotEvent.DISK_WAS_STARTED) );
					break;
					
				case SLOWS_DOWN:
					acceleration = -1;
					break;
					
				case SHAKES:
					speed = 0;
					acceleration = 1;
					break;
					
			}
		}
		
	//-------------------------------------------------------------
	//
	//  Methods
	//
	//-------------------------------------------------------------	
	
	
		/**
		 * begin the rotation
		 */
		public function go() : void
		{
			if ( STAY_STILL == state )
			{
				state = BEGIN_MOVEMENT;
			}
		}
		
		/**
		 * stop the rotation
		 */
		public function stop() : void
		{
			if ( IN_MOTION == state )
			{
				state = SLOWS_DOWN;
			}
		}
	
		private function afterStop() : void
		{
			var delta:int = -1 * position / 100;
			for ( var i:int = 0; i < 3; i++ )
			{
				var j:int = i + delta;
				if ( 0 > j )
				{
					j = 5 + j;
				}
				_results[i] = slots[j];
			}
			dispatchEvent( new SlotEvent(SlotEvent.DISK_WAS_STOPPED) );
		}
		
		private function centring() : void
		{
			position = 100 * Math.round(position / 100);
		}
		
		private function getEmptySlot() : int
		{
			var i:int = -1;
			
			do 
			{
				i = Math.round( Math.random() * 4 );
			} while ( null != slots[i] );
			
			return i;
		}
	
		private function fillSlots() : void
		{
			slots[ getEmptySlot() ] = a;
			slots[ getEmptySlot() ] = j;
			slots[ getEmptySlot() ] = ten;
			slots[ getEmptySlot() ] = k;
			slots[ getEmptySlot() ] = q;
		}
		
	//-------------------------------------------------------------
	//
	//  Event Listeners
	//
	//-------------------------------------------------------------	
	
	
		private function enterFrameHandler( event:Event ) : void
		{
			const SHAKE_AMPLITUDE:int = 5;
			
			switch ( state )
			{
				case BEGIN_MOVEMENT:
					if ( speedLimit == speed )
					{
						state = IN_MOTION;
					}
					break;
					
				case SLOWS_DOWN:
					if ( 5 > speed )
					{
						acceleration = 0;
					
						if ( 5 <= position % 100 )
						{
							centring();
							state = SHAKES;
						}
					}
					break;
					
				case SHAKES:
					if ( SHAKE_AMPLITUDE <= speed )
					{
						acceleration = -1;
					}
					
					if ( -1*SHAKE_AMPLITUDE >= speed )
					{
						centring();
						state = STAY_STILL;
						afterStop();
					}
					break;
					
			}
			
			speed += acceleration;
			position += speed;
			
		}
		
	}

}