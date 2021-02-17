pageextension 50051 CBRExtendBusinessManagerRole extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Issued Finance Charge Memos")
        {
            action("Posted Sales Invoices2")
            {
                Caption = 'Posted Sales Invoice';
                ApplicationArea = Basic, Suite;
                RunObject = Page "Posted Sales Invoice";
            }
        }
    }

    var
        myInt: Integer;
}