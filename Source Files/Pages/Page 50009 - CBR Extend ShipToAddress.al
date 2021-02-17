pageextension 50009 CBRShipToAddress extends "Ship-to Address"
{
    layout
    {
        // Add changes to page layout here
        addafter("Fax No.")
        {
            field("Telex Answer Back"; "Telex Answer Back")
            {
                Caption = 'Shipper Account No.';
                ApplicationArea = All;
            }
            field("CBR GLN"; "CBR GLN")
            {
                ApplicationArea = All;
                Caption = 'GLN';
            }
            field("CBR Member ID"; "CBR Member ID")
            {
                ApplicationArea = All;
                Caption = 'Member ID';
            }
            field("CBR License No."; "CBR License No.")
            {
                ApplicationArea = All;
                Caption = 'License No.';
            }
        }

        addafter("Shipping Agent Service Code")
        {
            field("CBR Free Shipping"; "CBR Free Shipping")
            {
                ApplicationArea = All;
                Caption = 'Free Shipping';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //CBRUpdateDShipInfo;
    end;

    var
        myInt: Integer;
}