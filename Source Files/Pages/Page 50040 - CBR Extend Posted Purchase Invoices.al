pageextension 50040 CBRExtendPostPurchaseInvoices extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Due Date")
        {
            field("Posting Description"; "Posting Description")
            {
                Caption = 'Description';
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