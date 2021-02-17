pageextension 50015 CBRExtendSalesOrderList extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here

        addafter("Ship-to Contact")
        {
            field("Order Date"; "Order Date")
            {
                ApplicationArea = All;
                Caption = 'Order Date';
            }
        }
        addafter(Status)
        {
            field(Comment; Comment)
            {
                ApplicationArea = All;
                Caption = 'Comments';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Print Confirmation")
        {
            action("CBR Closed Orders")
            {
                ApplicationArea = All;
                Caption = 'Closed Orders';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    SalesHead.RESET;
                    SalesHead.SETRANGE("Document Type", SalesHead."Document Type"::Order);
                    IF SalesHead.FIND('-') THEN BEGIN
                        REPEAT
                            Processed := TRUE;
                            SalesLine.RESET;
                            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.SETRANGE("Document No.", SalesHead."No.");
                            IF SalesLine.FINDSET THEN
                                REPEAT
                                    IF SalesLine.Quantity <> SalesLine."Quantity Invoiced" THEN BEGIN
                                        Processed := FALSE;
                                        BREAK;
                                    END;
                                UNTIL SalesLine.NEXT = 0;
                            IF Processed THEN
                                SalesHead."CBR Closed" := TRUE
                            ELSE
                                SalesHead."CBR Closed" := FALSE;
                            SalesHead.MODIFY;
                        UNTIL SalesHead.NEXT = 0;
                    END;
                end;

            }
        }
    }

    var
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Processed: Boolean;
}