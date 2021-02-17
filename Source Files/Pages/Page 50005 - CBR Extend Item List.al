pageextension 50005 CBRExtendItemList extends "Item List"
{
    layout
    {
        addbefore(Control1901314507)
        {
            part(ItemIncomingAttachments; "Item Incoming Attachments")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");

            }
        }
        // Add changes to page layout here
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Caption = 'Description 2';
            }
        }
        addafter("Standard Cost")
        {
            field("Qty. on Purch. Order"; "Qty. on Purch. Order")
            {
                ApplicationArea = All;
                Caption = 'Qty. on Purch. Order';
            }
            field("Qty. on Sales Order"; "Qty. on Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Qty. on Sales Order';
            }
            field(QtyAvailable; QtyAvailable)
            {
                ApplicationArea = All;
                Caption = 'Qty Available';
            }
            field(QtyToReorder; QtyToReorder)
            {
                ApplicationArea = All;
                Caption = 'Qty To Reorder';
            }
        }
        addafter("Unit Price")
        {
            field("CBR Default Selling Price"; "CBR Default Selling Price")
            {
                ApplicationArea = All;
                Caption = 'Default Selling Price';
            }
            field(ItemUOM; ItemUOM."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Case Pack Qty';
            }
            field(Inventory; Inventory / (ItemUOM."Qty. per Unit of Measure"))
            {
                ApplicationArea = All;
                Caption = 'Case Qty on Hand';
            }
            field("Unit Price 2"; "Unit Price" * ItemUOM."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Case Unit Price';
            }
            field("Unit Cost 2"; "Unit Cost" * ItemUOM."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Case Unit Cost';
            }
        }
        addafter("Item Disc. Group")
        {
            field("Manufacturer Code"; "Manufacturer Code")
            {
                ApplicationArea = All;
                Caption = 'Manufacturer Code';
            }
        }
        addafter("Default Deferral Template Code")
        {
            field(Picture; Picture)
            {
                ApplicationArea = All;
                Caption = 'Picture';
            }
        }

    }


    actions
    {
        // Add changes to page actions here
        addafter("C&alculate Counting Period")
        {
            action("CBR Show All Items")
            {
                ApplicationArea = All;
                Caption = 'Show All Items';
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditFilter;

                trigger OnAction()
                begin
                    Reset();
                end;
            }

            action("CBR Show Block Items")
            {
                ApplicationArea = All;
                Caption = 'Show Block Items';
                Image = ShowSelected;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Reset();
                end;

            }
        }

        addafter("Stockkeepin&g Units")
        {
            action("CBR Item Stock Status Info")
            {
                ApplicationArea = All;
                Caption = 'Item Stock Status Info';
                Image = SNInfo;
                RunObject = Page "Item Stock Status Info";
                RunPageLink = "Item No." = FIELD("No.");
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETRANGE(Blocked, FALSE);//CBR_SS 18Dec18
    end;

    trigger OnAfterGetRecord()
    begin
        //CBR_SS_05032018..>>
        IF ItemUOM.GET("No.", "Sales Unit of Measure") THEN;
        CALCFIELDS(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
        QtyAvailable := Inventory + "Qty. on Purch. Order" - "Qty. on Sales Order";
        QtyToReorder := "Reorder Quantity" - QtyAvailable;
        //CBR_SS_05032018..<<
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //CBR_SS_05032018..>>
        CALCFIELDS(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order");
        QtyAvailable := Inventory + "Qty. on Purch. Order" - "Qty. on Sales Order";
        QtyToReorder := "Reorder Quantity" - QtyAvailable;
        //CBR_SS_05032018..<<
    end;

    var
        QtyAvailable: Decimal;
        QtyToReorder: Decimal;
        ItemUOM: Record "Item Unit of Measure";
}