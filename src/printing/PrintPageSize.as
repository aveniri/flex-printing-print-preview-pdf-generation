package printing
{
	public class PrintPageSize
	{
		public static const A3_SIZE:PrintPageSize = new PrintPageSize("A3", 842, 1191);//11.69 x 16.54 * 72
		public static const A4_SIZE:PrintPageSize = new PrintPageSize("A4", 595, 842); //8.27 x 11.69 * 72
		public static const A5_SIZE:PrintPageSize = new PrintPageSize("A5", 420, 595); //5.83 x 8.27 * 72
		public static const LETTER_SIZE:PrintPageSize = new PrintPageSize("Letter", 612, 792);//8.5 x 11 * 72
		public static const LEGAL_SIZE:PrintPageSize = new PrintPageSize("Legal", 612, 1008);//8.5 x 14 * 72
		public static const TABLOID:PrintPageSize = new PrintPageSize("Tabloid", 792, 1224);
		
		public static const LANDSCAPE:String = "Landscape";
		public static const PORTRAIT:String = "Portrait";
		
		public static var sizes:Array = [ 	PrintPageSize.A3_SIZE, 
											PrintPageSize.A4_SIZE, 
											PrintPageSize.A5_SIZE,
											PrintPageSize.LEGAL_SIZE, 
											PrintPageSize.LETTER_SIZE, 
											PrintPageSize.TABLOID ];
		
		public static var orientations:Array = [PrintPageSize.PORTRAIT, 
												PrintPageSize.LANDSCAPE ];
		
		private var _labelName:String = "A4";
		private var _shortSide:int = 0;
		private var _longSide:int = 0;
		
		public function PrintPageSize(lblname:String = "A4", short:int = 0, long:int = 0 )
		{
			_labelName = lblname;
			_shortSide = short;
			_longSide = long;
		}
						
		public function get labelName():String
		{
			return _labelName;
		}
		
		public function set labelName(value:String):void
		{
			_labelName = value;
		}
		
		public function get shortSide():int
		{
			return _shortSide;
		}
		
		public function set shortSide(value:int):void
		{
			_shortSide = value;
		}
		
		public function get longSide():int
		{
			return _longSide;
		}
		
		public function set longSide(value:int):void
		{
			_longSide = value;
		}

	}
}