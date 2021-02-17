page 50019 "Item Sales History"
{
    // CBR_SS_ : 30/03/2018 : Created New Page

    Caption = 'Item Sales History';
    Editable = false;
    PageType = List;
    Permissions = TableData "Item Ledger Entry" = rimd,
                  TableData "Value Entry" = rimd;
    SourceTable = "CBR Item Sales History";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Customer No"; "Customer No")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Original Sales Order No"; "Original Sales Order No")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to State"; "Bill-to State")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Zip"; "Bill-to Zip")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address2"; "Ship-to Address2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to State"; "Ship-to State")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Zip"; "Ship-to Zip")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Due date"; "Due date")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; "Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Method Code"; "Shipping Method Code")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; "Item Description")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty Invoiced"; "Qty Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (Item)"; "Unit Cost (Item)")
                {
                    ApplicationArea = All;
                }
                field("Extended Price"; "Extended Price")
                {
                    ApplicationArea = All;
                }
                field("Extended Cost"; "Extended Cost")
                {
                    ApplicationArea = All;
                }
                field("Margin Amount"; "Margin Amount")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Code"; "Manufacturer Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; "Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No"; "Vendor Item No")
                {
                    ApplicationArea = All;
                }
                field("Item Category"; "Item Category")
                {
                    ApplicationArea = All;
                }
                field("Cross Reference No"; "Cross Reference No")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000005; "Lot Detail Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("Invoice No"),
                              "Item No." = FIELD("Item No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShoInvoice)
            {
                Caption = 'Show Invoice';
                Image = SalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    DocNo: Code[20];
                begin
                    if SalesInvHead.Get("Invoice No") then
                        PAGE.RunModal(PAGE::"Posted Sales Invoice", SalesInvHead)
                end;
            }
            action(ShowtrackingLine)
            {
                Caption = 'Show Tracking Line';
                Image = TraceOppositeLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ShowItemTrackingLines;
                end;
            }
            action("Create Lines")
            {
                Caption = 'Refresh Data';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    UpdateItemHistory;
                end;
            }
            action("Update ILE")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ILE: Record "Item Ledger Entry";
                    VLE: Record "Value Entry";
                begin
                    if ILE.Get(132644) then begin
                        ILE.Quantity := -3;
                        ILE."Invoiced Quantity" := 3;
                        ILE.Positive := false;
                        ILE.Modify;
                        Message('done');
                    end;

                    if VLE.Get(161735) then begin
                        VLE."Cost Amount (Actual)" := -11.44;
                        VLE."Sales Amount (Actual)" := 22.98;
                        VLE."Item Ledger Entry Quantity" := -3;
                        VLE."Valued Quantity" := -3;
                        VLE."Invoiced Quantity" := -3;
                        VLE.Modify;
                        Message('VLE done');

                    end;
                end;
            }
        }
    }

    var
        SalesInvHead: Record "Sales Invoice Header";
        RecItem: Record Item;
        TotalPrice: Decimal;

    local procedure CheckValues()
    var
        SalesinvHeader: Record "Sales Invoice Header";
        SInvLine: Record "Sales Invoice Line";
        SalesCrMoHeader: Record "Sales Cr.Memo Header";
        SalesCrMoLine: Record "Sales Cr.Memo Line";
        DateFrom: Date;
        DateTo: Date;
        SInvTaxAmt: Decimal;
        SCrTaxAmt: Decimal;
        VATEntry: Record "VAT Entry";
        VatAmount: Decimal;
        DateFilter: Text;
    begin
        DateFrom := 20180101D;
        DateFrom := 20180531D;
        DateFilter := '01/01/18..07/31/18';
        SInvTaxAmt := 0;
        SCrTaxAmt := 0;

        SalesinvHeader.Reset;
        //SalesinvHeader.SETFILTER("Posting Date",DateFilter);
        if SalesinvHeader.Find('-') then
            repeat
                SInvTaxAmt := SInvTaxAmt + (SalesinvHeader."Amount Including VAT" - SalesInvHead.Amount);
            until SalesinvHeader.Next = 0;

        SalesCrMoHeader.Reset;
        //SalesCrMoHeader.SETFILTER("Posting Date",DateFilter);
        if SalesCrMoHeader.Find('-') then
            repeat
                SCrTaxAmt := SCrTaxAmt + (SalesCrMoHeader."Amount Including VAT" - SalesCrMoHeader.Amount);
            until SalesCrMoHeader.Next = 0;

        VATEntry.Reset;
        //VATEntry.SETFILTER("Posting Date",DateFilter);
        if VATEntry.FindFirst then
            repeat
                VatAmount := VatAmount + VATEntry.Amount;
            until VATEntry.Next = 0;


        Message('Total Tax Amount %1', SInvTaxAmt);
        Message('Total Sales Cr.Tax Amount %1', SCrTaxAmt);

        Message('Total VAT Amount %1', VatAmount);
    end;
}

