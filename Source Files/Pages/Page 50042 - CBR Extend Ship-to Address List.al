pageextension 50042 CBRExtendShiptoAddressList extends "Ship-to Address List"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Telex Answer Back"; "Telex Answer Back")
            {
                Caption = 'ShipperAcctNo';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}