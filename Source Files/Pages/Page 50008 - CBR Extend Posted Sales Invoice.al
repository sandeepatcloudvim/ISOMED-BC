pageextension 50008 CBRExtendPostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Cancel")
        {
            action("CBR Pick Instruction")
            {
                ApplicationArea = All;
                Caption = 'Pick Instruction';
                Image = Print;
                Promoted = true;
                trigger OnAction()
                begin
                    //CBR-SS-9/17
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50006, TRUE, FALSE, Rec);
                    //CBR-SS-9/17
                end;
            }
            action("CBR Packing Slip")
            {
                ApplicationArea = All;
                Caption = 'Packing Slip';
                Image = Print;
                Promoted = true;
                trigger OnAction()
                begin
                    //CBR-SS-02/19/19
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50007, TRUE, FALSE, Rec);
                    //CBR-SS-02/19/19
                end;
            }
        }

        addafter(Print)
        {
            action("CBR PrintJob")
            {
                ApplicationArea = All;
                Caption = 'PrintJob';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50028, TRUE, FALSE, Rec);
                    RESET;
                end;
            }
        }

        addafter(ShowCreditMemo)
        {
            action("CBR Changes Sales Person")
            {
                Caption = 'Changes Sales Person';
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                begin
                    CBRChangesSalesPerson();
                end;
            }
        }
        addafter("&Invoice")
        {
            action("Vizient Sales")
            {
                CaptionML = ENU = 'Vizient Sales';
                ApplicationArea = Basic, Suite;
                RunObject = Report "Vizient Sales";
                Promoted = true;
                PromotedIsBig = true;
                Image = Sales;
                PromotedCategory = Report;
            }
            action("Sales Commission")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'IsoMed Sales Commission';
                RunObject = Report "IsoMed Sales Commission";
                Promoted = true;
                PromotedIsBig = true;
                Image = SalesPerson;
                PromotedCategory = Report;
            }
            action("Sales by Ship-to")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales by Ship-to';
                RunObject = Report "Sales Inv Credit Memo ISO";
                Promoted = true;
                PromotedIsBig = true;
                Image = Invoice;
                PromotedCategory = Report;
            }
        }
    }

    LOCAL procedure CBRChangesSalesPerson()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        ValueEntry: Record "Value Entry";
    begin
        IF SalesShipmentHeader.GET('116618') THEN BEGIN
            SalesShipmentHeader."Salesperson Code" := 'ISO2';
            SalesShipmentHeader.MODIFY;
            MESSAGE('Done');
        END;
        IF SalesInvoiceHeader.GET('INV18-24653') THEN BEGIN
            SalesInvoiceHeader."Salesperson Code" := 'ISO2';
            SalesInvoiceHeader.MODIFY;
            MESSAGE('Done');
        END;
        IF CustLedgerEntry.GET(171228) THEN BEGIN
            CustLedgerEntry."Salesperson Code" := 'ISO2';
            CustLedgerEntry.MODIFY;
            MESSAGE('Done');
        END;

        ValueEntry.RESET;
        ValueEntry.SETRANGE("Document No.", 'INV18-24653');
        ValueEntry.SETRANGE("Posting Date", 20180325D);
        IF ValueEntry.FINDFIRST THEN BEGIN
            ValueEntry.MODIFYALL("Salespers./Purch. Code", 'ISO2');
            MESSAGE('Done');
        END;
    end;

    var
        myInt: Integer;
}