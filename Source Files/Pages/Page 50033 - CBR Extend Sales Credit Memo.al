pageextension 50033 CBRExtendSalesCreditMemo extends "Sales Credit Memo"
{
    layout
    {
        addafter("Bill-to")
        {
            field("Ship-to Code"; "Ship-to Code")
            {
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