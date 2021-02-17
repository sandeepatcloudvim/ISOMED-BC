report 50022 "Track Prod Label for Item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrackProdLabelforItem.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");
            PrintOnlyIfDetail = true;
            column(Entry_No_ILE; "Item Ledger Entry"."Entry No.")
            {
            }
            column(Description_ILE; recItem.Description)
            {
            }
            column(Company_Logo; CompanyInformation.Picture)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(Item_No_ILE; "Item Ledger Entry"."Item No.")
                    {
                    }
                    column(Posting_Date_ILE; "Item Ledger Entry"."Posting Date")
                    {
                    }
                    column(Source_No_ILE; "Item Ledger Entry"."Source No.")
                    {
                    }
                    column(Document_No_ILE; "Item Ledger Entry"."Document No.")
                    {
                    }
                    column(Location_Code_ILE; "Item Ledger Entry"."Location Code")
                    {
                    }
                    column(Quantity_ILE; "Item Ledger Entry".Quantity)
                    {
                    }
                    column(Document_Type_ILE; "Item Ledger Entry"."Document Type")
                    {
                    }
                    column(Document_Line_No_ILE; "Item Ledger Entry"."Document Line No.")
                    {
                    }
                    column(Order_Type_ILE; "Item Ledger Entry"."Order Type")
                    {
                    }
                    column(Order_No_ILE; "Item Ledger Entry"."Order No.")
                    {
                    }
                    column(Order_Line_No_ILE; "Item Ledger Entry"."Order Line No.")
                    {
                    }
                    column(Lot_No_ILE; "Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(Warranty_Date_ILE; "Item Ledger Entry"."Warranty Date")
                    {
                    }
                    column(Expiration_Date_ILE; "Item Ledger Entry"."Expiration Date")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Item Ledger Entry".CalcFields("Cost Amount (Actual)");

                        Clear(LineUnitCost);
                        Clear(OrderNo);
                        Clear(VenCusName);

                        SalesShipmentLine.Reset;
                        SalesShipmentLine.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                        SalesShipmentLine.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if SalesShipmentLine.FindFirst then begin
                            SalesRecipt.Get(SalesShipmentLine."Document No.");
                            OrderNo := SalesRecipt."Order No.";
                            VenCusName := SalesRecipt."Sell-to Customer Name";
                        end;

                        PurchRcptLine.Reset;
                        PurchRcptLine.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                        PurchRcptLine.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if PurchRcptLine.FindFirst then begin
                            PurchaseRecipt.Get(PurchRcptLine."Document No.");
                            OrderNo := PurchaseRecipt."Order No.";
                            VenCusName := PurchaseRecipt."Buy-from Vendor Name";
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                    TaxAmount := 0;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.CalcFields(Picture);
                if recItem.Get("Item No.") then;

                if "Posting Date" <> 0D then
                    UseDate := "Posting Date"
                else
                    UseDate := WorkDate;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                }
                group(Control1000000000)
                {
                    ShowCaption = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Vend: Record Vendor;
        CompanyAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        UseExternalTaxEngine: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PurchLine: Record "Purchase Line";
        Checked: Boolean;
        ILE: Record "Item Ledger Entry";
        SalesRecipt: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        PurchaseRecipt: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        OrderNo: Code[20];
        PurchaseOrderNo: Code[20];
        LineUnitCost: Decimal;
        recItem: Record Item;
        VenCusName: Text;
        Text000: Label 'COPY';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        ToCaptionLbl: Label 'To:';
        CASCaption_Lbl: Label 'CAS:';
        DateEnteredCaption_Lbl: Label 'Date entered:';
        ChemIDCaption_Lbl: Label 'ChemID:';
        PKSCaption_Lbl: Label 'pks barcode';
        LotCaption_Lbl: Label 'Lot#:';
        ExpiryDateCaption_Lbl: Label 'Exp. date:';
        Purity_Caption_Lbl: Label 'Purity:';
        Manufacturer_Caption_Lbl: Label 'Mfg:';
        WholeSalerCaption_Lbl: Label 'Wholesaler:';
        OrderCaption_Lbl: Label 'Ord#:';
        COfACaption_Lbl: Label 'CofA';
        CheckedCaption_Lbl: Label 'Checked';
        PackSizeCaption_Lbl: Label 'PackSize:';
        AWPCaption_Lbl: Label 'AWP:';
        PackageCost_Caption_Lbl: Label 'Package Cost:';
        NDCCaption_Lbl: Label 'NDC';
}

