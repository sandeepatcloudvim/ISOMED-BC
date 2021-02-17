page 50020 "Lot Detail Factbox"
{
    // CBR_SS_ : 30/03/2018 : Created New Page to show lot detaisl in Factbox

    PageType = CardPart;
    SourceTable = "Value Entry";
    SourceTableView = WHERE("Invoiced Quantity" = FILTER(<> 0));

    layout
    {
        area(content)
        {
            repeater("Lot Details")
            {
                field("Lot No."; ILE."Lot No.")
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies a lot number if the posted item carries such a number.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ILE.SetRange("Entry No.", "Item Ledger Entry No.");
                        ILE.SetFilter("Lot No.", '<>%1', '');
                        PAGE.RunModal(6511, ILE);
                    end;
                }
                field(Quantity; -1 * ILE.Quantity)
                {
                    ApplicationArea = ItemTracking;
                    ToolTip = 'Specifies a serial number if the posted item carries such a number.';
                }
                field("Expiration Date"; ILE."Expiration Date")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Exp. Date';
                    ToolTip = 'Specifies the last date that the item on the line can be used.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //ILE.GET("Item Ledger Entry No.");
        ILE.SetRange("Entry No.", "Item Ledger Entry No.");
        ILE.SetFilter("Lot No.", '<>%1', '');
        if ILE.FindFirst then;
    end;

    var
        ILE: Record "Item Ledger Entry";
}

