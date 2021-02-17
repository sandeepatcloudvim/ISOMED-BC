pageextension 50041 CBRExtendPaymentJournal extends "Payment Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field("CBR Account Name"; "CBR Account Name")
            {
                Caption = 'Account Name';
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