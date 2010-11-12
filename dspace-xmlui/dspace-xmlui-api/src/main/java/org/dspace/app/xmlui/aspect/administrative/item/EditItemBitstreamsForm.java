/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.app.xmlui.aspect.administrative.item;

import java.sql.SQLException;

import org.dspace.app.xmlui.cocoon.AbstractDSpaceTransformer;
import org.dspace.app.xmlui.wing.Message;
import org.dspace.app.xmlui.wing.WingException;
import org.dspace.app.xmlui.wing.element.Body;
import org.dspace.app.xmlui.wing.element.Button;
import org.dspace.app.xmlui.wing.element.Cell;
import org.dspace.app.xmlui.wing.element.CheckBox;
import org.dspace.app.xmlui.wing.element.Division;
import org.dspace.app.xmlui.wing.element.Highlight;
import org.dspace.app.xmlui.wing.element.List;
import org.dspace.app.xmlui.wing.element.PageMeta;
import org.dspace.app.xmlui.wing.element.Para;
import org.dspace.app.xmlui.wing.element.Row;
import org.dspace.app.xmlui.wing.element.Table;
import org.dspace.authorize.AuthorizeManager;
import org.dspace.content.Bitstream;
import org.dspace.content.BitstreamFormat;
import org.dspace.content.Bundle;
import org.dspace.content.Item;
import org.dspace.core.Constants;

/**
 * Show a list of the item's bitstreams allowing the user to delete them, 
 * edit them, or upload new bitstreams.
 * 
 * @author Jay Paz
 * @author Scott phillips
 */

public class EditItemBitstreamsForm extends AbstractDSpaceTransformer {
	
	/** Language strings */
	private static final Message T_dspace_home = message("xmlui.general.dspace_home");
	private static final Message T_submit_return = message("xmlui.general.return");
	private static final Message T_item_trail = message("xmlui.administrative.item.general.item_trail");
	private static final Message T_option_head = message("xmlui.administrative.item.general.option_head");
	private static final Message T_option_status = message("xmlui.administrative.item.general.option_status");
	private static final Message T_option_bitstreams = message("xmlui.administrative.item.general.option_bitstreams");
	private static final Message T_option_metadata = message("xmlui.administrative.item.general.option_metadata");
	private static final Message T_option_view = message("xmlui.administrative.item.general.option_view");
        private static final Message T_option_curate = message("xmlui.administrative.item.general.option_curate");

	private static final Message T_title = message("xmlui.administrative.item.EditItemBitstreamsForm.title");
	private static final Message T_trail = message("xmlui.administrative.item.EditItemBitstreamsForm.trail");
	private static final Message T_head1 = message("xmlui.administrative.item.EditItemBitstreamsForm.head1");
	private static final Message T_column1 = message("xmlui.administrative.item.EditItemBitstreamsForm.column1");
	private static final Message T_column2 = message("xmlui.administrative.item.EditItemBitstreamsForm.column2");
	private static final Message T_column3 = message("xmlui.administrative.item.EditItemBitstreamsForm.column3");
	private static final Message T_column4 = message("xmlui.administrative.item.EditItemBitstreamsForm.column4");
	private static final Message T_column5 = message("xmlui.administrative.item.EditItemBitstreamsForm.column5");
	private static final Message T_bundle_label = message("xmlui.administrative.item.EditItemBitstreamsForm.bundle_label");
	private static final Message T_primary_label = message("xmlui.administrative.item.EditItemBitstreamsForm.primary_label");
	private static final Message T_view_link = message("xmlui.administrative.item.EditItemBitstreamsForm.view_link");
	private static final Message T_submit_add = message("xmlui.administrative.item.EditItemBitstreamsForm.submit_add");
	private static final Message T_submit_delete = message("xmlui.administrative.item.EditItemBitstreamsForm.submit_delete");

	private static final Message T_no_upload = message("xmlui.administrative.item.EditItemBitstreamsForm.no_upload");
	private static final Message T_no_remove = message("xmlui.administrative.item.EditItemBitstreamsForm.no_remove");
	
	public void addPageMeta(PageMeta pageMeta) throws WingException
	{
		pageMeta.addMetadata("title").addContent(T_title);

		pageMeta.addTrailLink(contextPath + "/", T_dspace_home);
		pageMeta.addTrailLink(contextPath + "/admin/item", T_item_trail);
		pageMeta.addTrail().addContent(T_trail);
	}

	
	public void addBody(Body body) throws SQLException, WingException
	{
		// Get our parameters and state
		int itemID = parameters.getParameterAsInteger("itemID",-1);
		Item item = Item.find(context, itemID);
		String baseURL = contextPath+"/admin/item?administrative-continue="+knot.getId();


		// DIVISION: main div
		Division main = body.addInteractiveDivision("edit-item-status", contextPath+"/admin/item", Division.METHOD_POST,"primary administrative item");
		main.setHead(T_option_head);

		
		
		// LIST: options
		List options = main.addList("options",List.TYPE_SIMPLE,"horizontal");
		options.addItem().addXref(baseURL+"&submit_status",T_option_status);
		options.addItem().addHighlight("bold").addXref(baseURL+"&submit_bitstreams",T_option_bitstreams);
		options.addItem().addXref(baseURL+"&submit_metadata",T_option_metadata);
		options.addItem().addXref(baseURL + "&view_item", T_option_view);
                options.addItem().addXref(baseURL + "&submit_curate", T_option_curate);

		
		
		// TABLE: Bitstream summary
		Table files = main.addTable("editItemBitstreams", 1, 1);

		files.setHead(T_head1);

		Row header = files.addRow(Row.ROLE_HEADER);
		header.addCellContent(T_column1);
		header.addCellContent(T_column2);
		header.addCellContent(T_column3);
		header.addCellContent(T_column4);
		header.addCellContent(T_column5);

		Bundle[] bundles = item.getBundles();

		for (Bundle bundle : bundles)
		{

			Cell bundleCell = files.addRow().addCell(1, 5);
			bundleCell.addContent(T_bundle_label.parameterize(bundle.getName()));



			Bitstream[] bitstreams = bundle.getBitstreams();

			for (Bitstream bitstream : bitstreams)
			{
				boolean primary = (bundle.getPrimaryBitstreamID() == bitstream.getID());
				String name = bitstream.getName();
		
				if (name != null && name.length() > 50)
				{
					// If the fiel name is too long the shorten it so that it will display nicely.
					String shortName = name.substring(0,15);
					shortName += " ... ";
					shortName += name.substring(name.length()-25,name.length());
					name = shortName;
				}
				
				String description = bitstream.getDescription();
				String format = null;
				BitstreamFormat bitstreamFormat = bitstream.getFormat();
				if (bitstreamFormat != null)
                {
                    format = bitstreamFormat.getShortDescription();
                }
				String editURL = contextPath + "/admin/item?administrative-continue="+knot.getId()+"&bitstreamID="+bitstream.getID()+"&submit_edit";
				String viewURL = contextPath + "/bitstream/id/"+bitstream.getID()+"/"+bitstream.getName();


				Row row = files.addRow();
				CheckBox remove = row.addCell().addCheckBox("remove");
				remove.setLabel("remove");
				remove.addOption(bundle.getID() + "/" +bitstream.getID() );
				if (!AuthorizeManager.authorizeActionBoolean(context, item, Constants.REMOVE))
				{
					remove.setDisabled();
				}

				if (AuthorizeManager.authorizeActionBoolean(context, bitstream, Constants.WRITE))
				{
					// The user can edit the bitstream give them a link.
					Cell cell = row.addCell();
					cell.addXref(editURL,name);
					if (primary)
                    {
                        cell.addXref(editURL, T_primary_label);
                    }
					
					row.addCell().addXref(editURL,description);
					row.addCell().addXref(editURL,format);
				}
				else
				{
					// The user can't edit the bitstream just show them it.
					Cell cell = row.addCell();
					cell.addContent(name);
					if (primary)
                    {
                        cell.addContent(T_primary_label);
                    }
					
					row.addCell().addContent(description);
					row.addCell().addContent(format);
				}
				
				Highlight highlight = row.addCell().addHighlight("fade");
				highlight.addContent("[");
				highlight.addXref(viewURL,T_view_link);
				highlight.addContent("]");
			}
		}

		if (AuthorizeManager.authorizeActionBoolean(context, item, Constants.ADD))
		{
			Cell cell = files.addRow().addCell(1, 5);
			cell.addXref(contextPath+"/admin/item?administrative-continue="+knot.getId()+"&submit_add",T_submit_add);
		}
		else
		{
			Cell cell = files.addRow().addCell(1, 5);
			cell.addHighlight("fade").addContent(T_no_upload);
		}

		
		
		// PARA: actions
		Para actions = main.addPara("editItemActionsP","editItemActionsP" );
        // Only System Administrators can delete bitstreams
		if (AuthorizeManager.authorizeActionBoolean(context, item, Constants.REMOVE))
        {
            actions.addButton("submit_delete").setValue(T_submit_delete);
        }
		else
		{
			Button button = actions.addButton("submit_delete");
			button.setValue(T_submit_delete);
			button.setDisabled();
			
			main.addPara().addHighlight("fade").addContent(T_no_remove);
		}
		actions.addButton("submit_return").setValue(T_submit_return);


		main.addHidden("administrative-continue").setValue(knot.getId());

	}
}
