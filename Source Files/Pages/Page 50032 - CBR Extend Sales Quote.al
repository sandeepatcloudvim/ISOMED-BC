pageextension 50032 CBRExtendSalesQuote extends "Sales Quote"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action(PrintJob)
            {
                ApplicationArea = All;
                Caption = 'Print Job';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Ellipsis = true;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50026, TRUE, FALSE, Rec);
                    RESET;
                end;


            }
        }
    }

    var
        myInt: Integer;
}