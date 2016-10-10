package screens 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.text.TextFieldAutoSize;
	
	import components.Edit;
	import components.Message;
	import components.slotMachine.Icon;
	import components.Button;
	import events.SlotEvent;
	import components.slotMachine.SlotMachineWL;
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
			disks.addEventListener( SlotEvent.DISKS_WERE_STARTED, disksWereStartedHandler, false, 0, true );
			disks.addEventListener( SlotEvent.MACHINE_IS_READY_TO_START, machineReadyToStartHandler, false, 0, true );
			disks.addEventListener( SlotEvent.WIN_LINES_ARE_CHECKED, winLinesAreCheckedHandler, false, 0, true );
			addChild( disks );
			
			var background:Bitmap = Embeded.getImage( Embeded.BACKGROUND ).bitmap;
			addChild( background );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			
			
			buttonSpin.x = 145;
			buttonSpin.y = 420;
			buttonSpin.addEventListener( MouseEvent.CLICK, buttonSpinClick, false, 0, true );
			addChild( buttonSpin );
			
			
			buttonStop.x = 145;
			buttonStop.y = 420;
			buttonStop.addEventListener( MouseEvent.CLICK, buttonStopClick, false, 0, true );
			
			var tf:TextField = new TextField();
			tf.text = 'Aqua Slots!';
			tf.setTextFormat( new TextFormat( null, 70, 0x80FFFF, false, true ) );
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.x = width - tf.width; tf.x /= 2;
			addChild( tf );
			
			editBalance.x = 500;
			editBalance.y = 120;
			addChild( editBalance );
			
			editWin.x = editBalance.x;
			editWin.y = 220;
			addChild( editWin );
			
			editBet.x = editBalance.x;
			editBet.y = 320;
			addChild( editBet );
			
			iconSoundOff.x = width - iconSoundOff.width - 10;
			iconSoundOff.y = height - iconSoundOff.height - 10;
			iconSoundOff.addEventListener( MouseEvent.CLICK, soundClickHandler, false, 0, true );
			iconSoundOn.x = iconSoundOff.x;
			iconSoundOn.y = iconSoundOff.y;
			iconSoundOn.addEventListener( MouseEvent.CLICK, soundClickHandler, false, 0, true );
			addChild( iconSoundOn );
			
			balance = 150;
			bet = 7;
			
			
		}
		
	//-------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------	
		
		private var disks:SlotMachineWL = new SlotMachineWL();
		private var buttonSpin:Button = new Button( "SPIN" );
		private var buttonStop:Button = new Button( "STOP", true );
		private var editBalance:Edit = new Edit( "Balance" );
		private var editWin:Edit = new Edit( "Win" );
		private var editBet:Edit = new Edit( "Bet" );
		private var iconSoundOn:Icon = Embeded.getImage( Embeded.SOUND_ON );
		private var iconSoundOff:Icon = Embeded.getImage( Embeded.SOUND_OFF );
		
		private var _balance:int;
		private var _bet:int;
		private var _win:int = 0;
		
	//-------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------	
			
		private function get balance() : int
		{
			return _balance;
		}
		
		private function set balance( value:int ) : void
		{
			_balance = value;
			editBalance.value = balance;
		}
		
		private function get bet() : int
		{
			return _bet;
		}
		
		private function set bet( value:int ) : void
		{
			_bet = value;
			editBet.value = bet;
		}
		
		private function get win() : int
		{
			return _win;
		}
		
		private function set win( value:int ) : void
		{
			_win = value;
			editWin.value = win;
		}
		
		
	
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
		
		
		private function buttonSpinClick( event:MouseEvent ) : void
		{
			if ( 0 == win )
			{
				if ( balance >= bet )
				{
					balance -= bet;
				}
				else
				{
					addChild( new Message() );
					return;
				}
			}
			else
			{
				balance += win;
				win = 0;
			}
			
			removeChild( buttonSpin );
			disks.go();
		}
		
		private function buttonStopClick( event:MouseEvent ) : void
		{
			removeChild( buttonStop );
			disks.stop();
		}
	
		private function disksWereStartedHandler( event:SlotEvent ) : void
		{
			addChild( buttonStop );
		}
		
		private function machineReadyToStartHandler( event:SlotEvent ) : void
		{
			addChild( buttonSpin );
		}
		
		private function soundClickHandler( event:MouseEvent ) : void
		{
			if ( event.target == iconSoundOff )
			{
				removeChild( iconSoundOff );
				addChild( iconSoundOn );
				Embeded.mute = false;
			}
			else
			{
				removeChild( iconSoundOn );
				addChild( iconSoundOff );
				Embeded.mute = true;
			}
		}
		
		private function stageKeyUpHandler( event:KeyboardEvent ) : void
		{
			if ( Keyboard.SPACE == event.keyCode )
			{
				if ( null != buttonSpin.parent )
				{
					buttonSpinClick( null );
				}
				
				if ( null != buttonStop.parent )
				{
					buttonStopClick( null );
				}
			}
		}
		
		private function winLinesAreCheckedHandler( event:SlotEvent ) : void
		{
			win = disks.winLineQty * bet;
		}
		
	}

}