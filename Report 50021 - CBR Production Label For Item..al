report 50021 "Production Label For Item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ProductionLabelForItem.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(VendorName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(Company_Logo; recCompanyInfo.Picture)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(ExptRecptDt_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(CASCaptionLbl; CASCaption_Lbl)
                    {
                    }
                    column(ChemIDCaptionLbl; ChemIDCaption_Lbl)
                    {
                    }
                    column(PKSCaptionLbl; PKSCaption_Lbl)
                    {
                    }
                    column(LotCaptionLbl; LotCaption_Lbl)
                    {
                    }
                    column(ExpiryDateCaptionLbl; ExpiryDateCaption_Lbl)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
                        column(Line_No_PurchaseLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(Item_No_PurchaseLine; "Purchase Line"."No.")
                        {
                        }
                        column(Description_PurchaseLine; "Purchase Line".Description)
                        {
                        }
                        column(UnitPriceLCY_PurchaseLine; "Purchase Line"."Unit Price (LCY)")
                        {
                        }
                        column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(UnitCost_PuchaseLine; "Purchase Line"."Direct Unit Cost")
                        {
                        }
                        dataitem("Reservation Entry"; "Reservation Entry")
                        {
                            DataItemLink = "Item No." = FIELD("No."), "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.");
                            DataItemTableView = SORTING("Entry No.", Positive);
                            column(ItemNo_ReservationEntry; "Reservation Entry"."Item No.")
                            {
                            }
                            column(Lot_No_ReservationEntry; "Reservation Entry"."Lot No.")
                            {
                            }
                            column(Expiration_Date_ReservationEntry; "Reservation Entry"."Expiration Date")
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        var
                            RecReservationEntry: Record "Reservation Entry";
                            EnumPurchLine: Enum "Purchase Line Type";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            if ("Purchase Header"."Tax Area Code" <> '') and not UseExternalTaxEngine then
                                SalesTaxCalc.AddPurchLine("Purchase Line");

                            if "Vendor Item No." <> '' then
                                ItemNumberToPrint := "Vendor Item No."
                            else
                                ItemNumberToPrint := "No.";

                            //CBR_SS++
                            //if Type = 0 then begin
                            if EnumPurchLine = EnumPurchLine::" " then begin
                                //CBR_SS--
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                "Line Amount" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            end;

                            AmountExclInvDisc := "Line Amount";

                            if Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / Quantity, 0.00001);

                            if OnLineNumber = NumberOfLines then begin
                                PrintFooter := true;

                                if "Purchase Header"."Tax Area Code" <> '' then begin
                                    if UseExternalTaxEngine then
                                        SalesTaxCalc.CallExternalTaxEngineForPurch("Purchase Header", true)
                                    else
                                        SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                                    BrkIdx := 0;
                                    PrevPrintOrder := 0;
                                    PrevTaxPercent := 0;
                                    TaxAmount := 0;
                                    with TempSalesTaxAmtLine do begin
                                        Reset;
                                        SetCurrentKey("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                                        if Find('-') then
                                            repeat
                                                if ("Print Order" = 0) or
                                                   ("Print Order" <> PrevPrintOrder) or
                                                   ("Tax %" <> PrevTaxPercent)
                                                then begin
                                                    BrkIdx := BrkIdx + 1;
                                                    if BrkIdx > 1 then begin
                                                        if TaxArea."Country/Region" = TaxArea."Country/Region"::CA then
                                                            BreakdownTitle := Text006
                                                        else
                                                            BreakdownTitle := Text003;
                                                    end;
                                                    if BrkIdx > ArrayLen(BreakdownAmt) then begin
                                                        BrkIdx := BrkIdx - 1;
                                                        BreakdownLabel[BrkIdx] := Text004;
                                                    end else
                                                        BreakdownLabel[BrkIdx] := StrSubstNo("Print Description", "Tax %");
                                                end;
                                                BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + "Tax Amount";
                                                TaxAmount := TaxAmount + "Tax Amount";
                                            until Next = 0;
                                    end;
                                    if BrkIdx = 1 then begin
                                        Clear(BreakdownLabel);
                                        Clear(BreakdownAmt);
                                    end;
                                end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange("Line No.", PurchaseLineNo);

                            //CurrReport.CreateTotals(AmountExclInvDisc, "Line Amount", "Inv. Discount Amount");
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            PurchasePrinted.Run("Purchase Header");
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                    TaxAmount := 0;

                    Clear(BreakdownTitle);
                    Clear(BreakdownLabel);
                    Clear(BreakdownAmt);
                    TotalTaxLabel := Text008;
                    if "Purchase Header"."Tax Area Code" <> '' then begin
                        TaxArea.Get("Purchase Header"."Tax Area Code");
                        case TaxArea."Country/Region" of
                            TaxArea."Country/Region"::US:
                                TotalTaxLabel := Text005;
                            TaxArea."Country/Region"::CA:
                                TotalTaxLabel := Text007;
                        end;
                        UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                        SalesTaxCalc.StartSalesTaxCalculation;
                    end;
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

                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                if "Purchaser Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Purchaser Code");

                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");

                if not CurrReport.Preview then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    end;
                end;

                if "Posting Date" <> 0D then
                    UseDate := "Posting Date"
                else
                    UseDate := WorkDate;
            end;

            trigger OnPreDataItem()
            begin
                recCompanyInfo.CalcFields(Picture);
                Reset;
                SetRange("Document Type", "Purchase Header"."Document Type"::Order);
                SetRange("No.", PurchaseHeaderNo);
                if PrintCompany then
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                else
                    Clear(CompanyAddress);
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
                group(Control1000000003)
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
        recCompanyInfo.Get;
        recCompanyInfo.CalcFields(Picture);
    end;

    var
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
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
        recCompanyInfo: Record "Company Information";
        PurchaseHeaderNo: Code[20];
        PurchaseLineNo: Integer;


    procedure InitValue(DocumentNo: Code[20]; LineNo: Integer)
    begin
        PurchaseHeaderNo := DocumentNo;
        PurchaseLineNo := LineNo;
    end;
}

