pageextension 50052 CBRExtendSalesQuotes extends "Sales Quotes"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("CBR PrintJob")
            {
                ApplicationArea = Basic, Site;
                Caption = 'Print Job';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                //Visible = NOT IsOfficeAddin;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50028, TRUE, FALSE, Rec);
                    RESET;
                end;
            }
        }
    }

    var
        myInt: Integer;
}