pageextension 50031 CBRExtendVendorLedgerEntries extends "Vendor Ledger Entries"
{
    layout
    {
        modify("External Document No.")
        {
            Caption = 'Vendor Inv No.';
            ApplicationArea = All;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}