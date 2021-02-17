page 50023 "PO Lines not Invoiced"
{
    // CBR_SS 070518 - Added Code.

    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Qty. Rcd. Not Invoiced" = FILTER(> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PO No."; "Document No.")
                {
                    AssistEdit = true;
                    Caption = 'PO No.';
                    DrillDown = true;
                    DrillDownPageID = "Purchase Order";
                    Lookup = true;
                    LookupPageID = "Purchase Order";
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        Clear(PurchaseOrderPage);
                        recPurchaseHeader.SetRange("No.", "Document No.");
                        PurchaseOrderPage.SetTableView(recPurchaseHeader);
                        PurchaseOrderPage.LookupMode := true;
                        if PurchaseOrderPage.RunModal = ACTION::LookupOK then;
                    end;
                }
                field("PO Date"; "Order Date")
                {
                    Caption = 'PO Date';
                    ApplicationArea = All;
                }
                field("Vendor ID"; "Buy-from Vendor No.")
                {
                    Caption = 'Vendor ID';
                    ApplicationArea = All;
                }
                field("Vendor Name"; "CBR Vendor Name")
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = All;
                }
                field(ItemNo; "No.")
                {
                    Caption = 'Item No.';
                    Editable = false;
                    HideValue = false;
                    ApplicationArea = All;

                }
                field("Item Description"; Description)
                {
                    Caption = 'Item Description';
                    ApplicationArea = All;
                }
                field("Quantity Order"; Quantity)
                {
                    Caption = 'Quantity Order';
                    ApplicationArea = All;
                }
                field("Qty Received"; "Quantity Received")
                {
                    Caption = 'Qty Received';
                    ApplicationArea = All;
                }
                field("Qty Invoiced"; "Quantity Invoiced")
                {
                    Caption = 'Qty Invoiced';
                    ApplicationArea = All;
                }
                field("Last Shipment Date"; "CBR Last Shipment Date")
                {
                    Caption = 'Last Shipment Date';
                    ApplicationArea = All;
                }
                field("Unit Amount"; "Unit Cost")
                {
                    Caption = 'Unit Amount';
                    ApplicationArea = All;
                }
                field("Original PO Amount"; Amount)
                {
                    Caption = 'Original PO Amount';
                    ApplicationArea = All;

                }
                field("Qty. Rcd. Not Invoiced"; "Qty. Rcd. Not Invoiced")
                {
                    Caption = 'Qty. Rcd. Not Invoiced';
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced"; "Amt. Rcd. Not Invoiced")
                {
                    Caption = 'Amt. Rcd. Not Invoiced';
                    ApplicationArea = All;
                }
                field("Total Amount UnInvoiced"; TotalAmountUnInvoiced)
                {
                    Caption = 'Total Amount UnInvoiced';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Show Card")
            {
                Caption = 'View';
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Clear(PurchaseOrderPage);
                    recPurchaseHeader.SetRange("No.", "Document No.");
                    PurchaseOrderPage.SetTableView(recPurchaseHeader);
                    PurchaseOrderPage.Run;
                end;
            }
            action(Update)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    SalesHeader.SetRange("Ship-to Code", '<>%1', '');
                    SalesHeader.SetRange("Ship-to Code", '<>%1', 'ST*');
                    if SalesHeader.FindFirst then
                        repeat
                            ShipToAddress.Reset;
                            ShipToAddress.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
                            ShipToAddress.SETRANGE("CBR Old Ship-To Code", SalesHeader."Ship-to Code");
                            if ShipToAddress.FindFirst then begin
                                SalesHeader."Ship-to Code" := ShipToAddress.Code;
                                SalesHeader.Modify;
                            end;

                        until SalesHeader.Next = 0;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdatePOLines;//CBR_SS
    end;

    var
        VendorName: Record Vendor;
        PurchaseHeader: Record "Purchase Header";
        TotalAmountUnInvoiced: Decimal;
        PurchaseOrderPage: Page "Purchase Order";
        recPurchaseHeader: Record "Purchase Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        SalesHeader: Record "Sales Header";
        ShipToAddress: Record "Ship-to Address";

    local procedure UpdatePOLines()
    var
        PHeader: Record "Purchase Header";
    begin
        //CBR_SS++
        IF PHeader.GET("Document Type"::Order, "Document No.") THEN
            VendorName.GET(PHeader."Buy-from Vendor No.");

        IF "Buy-from Vendor No." = '' THEN
            "Buy-from Vendor No." := VendorName."No.";
        IF "CBR Vendor Name" = '' THEN
            "CBR Vendor Name" := VendorName.Name;
        PurchRcptHeader.RESET;
        PurchRcptHeader.SETRANGE("Order No.", "Document No.");
        IF PurchRcptHeader.FINDLAST THEN
            "CBR Last Shipment Date" := PurchRcptHeader."Posting Date";
        MODIFY;
        TotalAmountUnInvoiced := "Quantity Received" * "Unit Cost";
        //CBR_SS--
    end;
}

