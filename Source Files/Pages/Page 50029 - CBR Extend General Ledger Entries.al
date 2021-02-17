pageextension 50029 CBRExtendGeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Document Date"; "Document Date")
            {
                ApplicationArea = All;
                Caption = 'Document Date';
            }
        }
        addafter("Source Code")
        {
            field("Source Type"; "Source Type")
            {
                ApplicationArea = All;
                Caption = 'Source Type';
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