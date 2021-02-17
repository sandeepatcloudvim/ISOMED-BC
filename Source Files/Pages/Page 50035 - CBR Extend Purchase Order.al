pageextension 50035 CBRExtendPurchaseOrder extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Item Qty On Sales Order")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Backorder fulfillment';
                Promoted = true;
                Image = CalculateConsumption;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CLEAR(recPurchOrd);
                    recPurchOrd := Rec;
                    recPurchOrd.SETRANGE("No.", Rec."No.");
                    //REPORT.RUNMODAL(REPORT::Report50000,TRUE,FALSE,purchOrd);
                    REPORT.RUN(REPORT::"BackOrder Fullfilment", TRUE, FALSE, recPurchOrd);
                end;
            }
        }
    }

    var
        myInt: Integer;
        recPurchOrd: Record "Purchase Header";
}