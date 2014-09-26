package printing
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.CheckBox;
	import mx.controls.listClasses.IListItemRenderer;
	
	public class ADGridExtended extends AdvancedDataGrid
	{
		public function ADGridExtended()
		{
			super();
		}
		
		
		override protected function selectItem(item:IListItemRenderer,
											   shiftKey:Boolean, ctrlKey:Boolean,
											   transition:Boolean = true):Boolean
		{
			// only run selection code if a checkbox was hit and always
			// pretend we're using ctrl selection
			
			if (item is CheckBox)
				return super.selectItem(item, shiftKey, true, transition);
			else //Avenir Cokaj 23/06/11: this enables the flex's natural selection
				return super.selectItem(item, shiftKey, ctrlKey, transition);
			
		}
		
		// whenever we draw the renderer, make sure we re-eval the checked state
		override protected function drawItem(item:IListItemRenderer,
											 selected:Boolean = false,
											 highlighted:Boolean = false,
											 caret:Boolean = false,
											 transition:Boolean = false):void
		{			
			
			// this resolves and issue when the Locked Columns are enabled
			// basicaly the child listens for an event by the parent so that it can 
			// execute the invalidateProperties() on itself (CheckBox)
			if(lockedColumnCount > 0)	
				dispatchEvent( new Event("refreshChBoxProperties"));
			else if(item is CheckBox)
				CheckBox(item).invalidateProperties();	
			
			super.drawItem(item, selected, highlighted, caret, transition);			
		}
		
		/*// turn off selection indicator
		override protected function drawSelectionIndicator(indicator:Sprite, x:Number, y:Number,
		width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void
		{	}*/
		
		// fake all keyboard interaction as if it had the ctrl key down
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			// this is technically illegal, but works
			event.ctrlKey = true;
			super.keyDownHandler(event);
		}		
		
	}
}