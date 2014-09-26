package printing
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.CheckBox;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.AdvancedListBase;
	import mx.controls.listClasses.ListBase;
	
	/** 
	 *  The Renderer.
	 */
	public class CheckBoxHeaderRenderer extends CheckBox 
	{
		
		public function CheckBoxHeaderRenderer()
		{
			focusEnabled = false;
			
			setStyle("highlightAlphas", [0.1, 0.8]);
			setStyle("fillAlphas", [1.0, 1.0, 1.0, 1.0]);
			setStyle("fillColors", [0xFFFFFF, 0xEEEEEE, 0x999999, 0xFFFFFF]);
			setStyle("borderColor", 0x000000);
			setStyle("themeColor", 0x666666);
		}
		
		private var _data:Object;
		
		override public function get data():Object
		{
			return _data;
		}
		
		override public function set data(value:Object):void
		{
			_data = value;
			invalidateProperties();
		}
		
		private var addedListener:Boolean = false;
		private var partiallySelected:Boolean = false;
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (owner is AdvancedListBase)
			{
				if (!addedListener){
					addedListener = true;
					owner.addEventListener("valueCommit", owner_changeHandler, false, 0, true);
					owner.addEventListener("change", owner_changeHandler, false, 0, true);
				}
				
				if(AdvancedListBase(owner).dataProvider != null){//CHECK IF DATA IS LOADED YET
					if (AdvancedListBase(owner).dataProvider.length == AdvancedListBase(owner).selectedItems.length)
					{
						selected = true;
						partiallySelected = false;
					}
					else if (AdvancedListBase(owner).selectedItems.length == 0)
					{
						selected = false;
						partiallySelected = false;
					}else
					{
						selected = false;
						partiallySelected = true;
					}
				}
				invalidateDisplayList();
			}
			else if(owner is ListBase)
			{
				if (!addedListener){
					addedListener = true;
					owner.addEventListener("valueCommit", owner_changeHandler, false, 0, true);
					owner.addEventListener("change", owner_changeHandler, false, 0, true);
				}
				
				if (ListBase(owner).dataProvider.length == 
					ListBase(owner).selectedItems.length)
				{
					selected = true;
					partiallySelected = false;
				}else if (ListBase(owner).selectedItems.length == 0){
					selected = false;
					partiallySelected = false;
				}else{
					selected = false;
					partiallySelected = true;
				}
				invalidateDisplayList();			
			}
		}
		
		/* eat keyboard events, the underlying list will handle them */
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
		}
		
		/* eat keyboard events, the underlying list will handle them */
		override protected function keyUpHandler(event:KeyboardEvent):void
		{
		}
		
		override protected function clickHandler(event:MouseEvent):void
		{
			if (selected)
			{
				// uncheck everything
				if (owner is AdvancedListBase)
					AdvancedListBase(owner).selectedIndex = -1;
				else 
					ListBase(owner).selectedIndex = -1;
			}
			else
			{
				var n:int;
				//check the right type of "List Base" in Grid"
				if (owner is AdvancedListBase)	n = AdvancedListBase(owner).dataProvider.length;
				else if(owner is ListBase)		n = ListBase(owner).dataProvider.length;
				
				var arr:Array = [];
				for (var i:int = i; i < n; i++)
					arr.push(i);
				
				//check the right type of "List Base" in Grid"
				if (owner is AdvancedListBase)	AdvancedListBase(owner).selectedIndices = arr;
				else if(owner is ListBase)		ListBase(owner).selectedIndices = arr;
					
			}
		}
		
		/* center the checkbox if we're in a datagrid */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			graphics.clear();
			
			if (listData is DataGridListData || listData is AdvancedDataGridListData)
			{
				var n:int = numChildren;
				for (var i:int = 0; i < n; i++)
				{
					var c:DisplayObject = getChildAt(i);
					if (!(c is TextField))
					{
						c.x = int((w - c.width) / 2);
						c.y = int((h - c.height) - 4);
						c.alpha = 1;
						if (partiallySelected)
						{
							/*graphics.beginFill(0xcccccc);
							graphics.drawRect(c.x, c.y, c.width, c.height);
							graphics.endFill();
							c.alpha = 0.5;
							*/
							graphics.lineStyle(2, 0x000000);
							graphics.beginFill(0xaaaaaa);
							graphics.drawRect(c.x+2, c.y+2, c.width-4, c.height-4);
							graphics.endFill();
							c.alpha = 0.5;
							
						}
					}
				}
			}
		}
		
		private function owner_changeHandler(event:Event):void
		{
			invalidateProperties();
		}
		
	}
	
}