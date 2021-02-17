page 50024 "Item Stock Status Info"
{
    Caption = 'Item Stock Status Info';
    Editable = false;
    PageType = List;
    Permissions = TableData "Purch. Rcpt. Line" = rimd;
    SourceTable = "CBR Item Stock Status Info";

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    Caption = 'Item No.';
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the item that exists as lot numbers in the bin.';
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = Warehouse;

                }
                field("Zone Code"; "Zone Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the zone that is assigned to the bin where the lot number exists.';
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Warehouse;
                }

                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the bin where the lot number exists.';
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the lot number that exists in the bin.';
                }
                field("Expiration Date"; "Expiration Date")
                {
                    ApplicationArea = Warehouse;
                }
                field("Warranty Date"; "Warranty Date")
                {
                    ApplicationArea = Warehouse;
                }
                field("Qty. (Base)"; "Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Quantity On Hand';
                    ToolTip = 'Specifies how many items with the lot number exist in the bin.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Data")
            {
                Image = UpdateShipment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    FillTempTable();
                end;
            }
            action("Update Purch Rect Line")
            {
                Visible = false;
                ApplicationArea = Warehouse;
                trigger OnAction()
                begin
                    PurchRectLine.Reset;
                    PurchRectLine.SetRange("Buy-from Vendor No.", '');
                    if PurchRectLine.FindFirst then
                        repeat
                            PurchRectLine."Buy-from Vendor No." := PurchRectLine."Pay-to Vendor No.";
                            PurchRectLine.Modify;
                        until PurchRectLine.Next = 0;

                    Message('completed');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FillTempTable;
    end;

    var
        PurchRectLine: Record "Purch. Rcpt. Line";
}

