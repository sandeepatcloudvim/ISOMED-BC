pageextension 50030 CBRExtendCustomerLedgerEntries extends "Customer Ledger Entries"
{
    layout
    {
        // modify("External Document No.")
        // {
        //     Caption = 'Customer Po No.';
        //     ApplicationArea = All;
        // }
        addafter(Description)
        {
            field("CBR External Document No."; "External Document No.")
            {
                Caption = 'Customer Po No.';
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