report 50006 "CBR Sales Inv Picking Ticket"
{
    // CBR_SS : 25/04/2018 : Added code to display Lot No. , Qty and Expiration Date.
    // CAN-SS -added code
    DefaultLayout = RDLC;
    RDLCLayout = './SalesInvPickingTicketCBR.rdl';
    Caption = 'Sales Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesHeader; "No.")
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption; ShpMethodDescCaptionLbl)
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PrepmtPmtTermsDescCaption; PrepmtPmtTermsDescCaptionLbl)
            {
            }
            column(ShipToName; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(ShipToName2; "Sales Invoice Header"."Ship-to Name 2")
            {
            }
            column(ShipToAddress; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShipToAddress2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShipToCity; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShipToCounty; "Sales Invoice Header"."Ship-to County")
            {
            }
            column(ShipToCountry; "Sales Invoice Header"."Ship-to Country/Region Code")
            {
            }
            column(ShipToZip; "Sales Invoice Header"."Ship-to Post Code")
            {
            }
            column(ShpMethodDesc; ShipmentMethod.Description)
            {
            }
            column(ShpMethodCode; ShipmentMethod.Code)
            {
            }
            column(ShpAgntCode; "Sales Invoice Header"."Shipping Agent Code")
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(TOTALamt; "Sales Invoice Header".Amount)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(CreatedByUser; "Sales Invoice Header"."CBR Created By UserID")
            {
            }
            column(CreatedByUserName; "Sales Invoice Header"."CBR Created By User Name")
            {
            }
            column(DocDate_inv; "Sales Invoice Header"."Document Date")
            {
            }
            column(ShipmentDate_; "Sales Invoice Header"."Shipment Date")
            {
            }
            column(AgenCode; "Sales Invoice Header"."Shipping Agent Code")
            {
            }
            dataitem(SalInvLine1; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(CommentTextArrayLine1; CommentTextArray[1])
                {
                }
                column(CommentTextArrayLine2; CommentTextArray[2])
                {
                }
                column(CommentTextArrayLine3; CommentTextArray[3])
                {
                }
                column(CommentTextArrayLine4; CommentTextArray[4])
                {
                }
                column(CommentTextArrayLine5; CommentTextArray[5])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //CBR_SS ++
                    SalInvLine1.Get("Document No.", "Line No.");
                    SalInvLine1.SetFilter(Description, '<>%1', '');
                    SalInvLine1.SetFilter("No.", '=%1', '');
                    SalInvLine1.SetFilter(Quantity, '=%1', 0);
                    i := 0;
                    if SalInvLine1.FindSet then
                        repeat
                            i := i + 1;
                            if i <= 5 then
                                CommentTextArray[i] := SalInvLine1.Description;
                        until SalInvLine1.Next = 0;
                    //CBR_SS --
                end;
            }
            dataitem(salesinv; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0));
                PrintOnlyIfDetail = true;
                dataitem(copy; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(pagel; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(CompanyInfoHomePage; CompanyInfo."E-Mail")
                        {
                        }
                        column(CompanyInfoEmail; CompanyInfo."Home Page")
                        {
                        }
                        column(CompanyInfo2Picture; CompanyInfo2.Picture)
                        {
                        }
                        column(CompanyInfo3Picture; CompanyInfo3.Picture)
                        {
                        }
                        column(CompanyInfo1Picture; CompanyInfo1.Picture)
                        {
                        }
                        column(UOM_; salesinv."Unit of Measure Code")
                        {
                        }
                        column(No_; salesinv."No.")
                        {
                        }
                        column(Dec_; salesinv.Description)
                        {
                        }
                        column(LineNo_; salesinv."Line No.")
                        {
                        }
                        column(Quantity_; salesinv.Quantity)
                        {
                        }
                        column(Lot_No_1; LotNoValue)
                        {
                        }
                        column(CustAddr1; CustAddr[1])
                        {
                        }
                        column(CustAddr2; CustAddr[2])
                        {
                        }
                        column(CustAddr3; CustAddr[3])
                        {
                        }
                        column(CustAddr4; CustAddr[4])
                        {
                        }
                        column(CustAddr5; CustAddr[5])
                        {
                        }
                        column(CustAddr6; CustAddr[6])
                        {
                        }
                        column(OutputNo; OutputNo)
                        {
                        }
                        column(ExtDocNo; "Sales Invoice Header"."External Document No.")
                        {
                        }
                        column(CustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //CAN-SS
                        if Number > 1 then begin
                            CopyText := FormatDocument.GetCOPYText;
                            OutputNo += 1;
                        end;
                        //CurrReport.PageNo := 1;
                        //CAN-SS
                    end;

                    trigger OnPreDataItem()
                    begin
                        //CAN-SS
                        NoOfLoops := Abs(NoOfCopies) + 1;
                        CopyText := '';
                        SetRange(Number, 1, NoOfLoops);
                        OutputNo := 1;
                        //CAN-SS
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //CBR_SS_15032018..>>
                    i := 0;
                    Clear(LotNo);
                    Clear(LotNoValue);
                    Clear(ExpDate);
                    //CAN-SS
                    Rowid := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line",
                        0, salesinv."Document No.", '', 0, salesinv."Line No.");

                    ValueEntryRelation.SetRange("Source RowId", Rowid);
                    if ValueEntryRelation.FindSet then
                        repeat

                            ValueEntry.SetRange("Entry No.", ValueEntryRelation."Value Entry No.");
                            if ValueEntry.FindFirst then begin
                                ItemLedgerEntry.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ItemLedgerEntry.FindSet then begin
                                    if ItemLedgerEntry."Lot No." <> 'NA' then begin
                                        Qty := Format(Abs(ValueEntry."Invoiced Quantity"));
                                        ExpDate := Format(ItemLedgerEntry."Expiration Date");
                                        LotNoValue += ' Lot No. : ' + ItemLedgerEntry."Lot No." + ' Qty : ' + Qty + ' Exp Date : ' + ExpDate + ' , ';
                                    end;
                                end;
                            end;
                        until ValueEntryRelation.Next = 0;
                    //CAN-SS
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OrderConfirmation; StrSubstNo(Text004, CopyText))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocumentDate_SalesHeader; "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegistrationNo_SalesHeader; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; "Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesHeader; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesHeader; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PricesIncVAT_SalesHeader; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(PricesInclVAT_SalesHeader; Format("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(CustTaxIdentificationType; Cust.GetLegalEntityType)
                    {
                    }
                    column(PmtTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPmtTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; Cust.GetLegalEntityTypeLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesIncVAT_SalesHeaderCaption; "Sales Invoice Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    // column(Page_No; CurrReport.PageNo)
                    // {
                    // }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.Find('-') then
                                    CurrReport.Break;
                            end else
                                if not Continue then
                                    CurrReport.Break;

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break;
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineLineAmount; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineDesc_SalesLine; "Sales Invoice Line".Description)
                        {
                        }
                        column(NNCSalesLineLineAmt; NNC_SalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt; NNC_SalesLineInvDiscAmt)
                        {
                        }
                        column(NNCTotalLCY; NNC_TotalLCY)
                        {
                        }
                        column(NNCTotalExclVAT; NNC_TotalExclVAT)
                        {
                        }
                        column(NNCVATAmt; NNC_VATAmt)
                        {
                        }
                        column(NNCPmtDiscOnVAT; NNC_PmtDiscOnVAT)
                        {
                        }
                        column(NNCTotalInclVAT2; NNC_TotalInclVAT2)
                        {
                        }
                        column(NNCVatAmt2; NNC_VatAmt2)
                        {
                        }
                        column(NNCTotalExclVAT2; NNC_TotalExclVAT2)
                        {
                        }
                        column(VATBaseDisc_SalesHeader; "Sales Invoice Header"."VAT Base Discount %")
                        {
                        }
                        column(No2_SalesLine; "Sales Invoice Line"."No.")
                        {
                        }
                        column(Quantity_SalesLine; "Sales Invoice Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesLine; "Sales Invoice Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine; "Sales Invoice Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine; "Sales Invoice Line"."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine; "Sales Invoice Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; "Sales Invoice Line"."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Sales Invoice Line"."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; Format("Sales Invoice Line".Type))
                        {
                        }
                        column(LineNo_SalesLine; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(AllwInvDiscformat_SalesLine; Format("Sales Invoice Line"."Allow Invoice Disc."))
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                        {
                        }
                        column(SalesLineInvDiscountAmt; SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesLineLineAmtInvDiscAmt; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmt; VATAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmtInvDiscAmtVATAmt; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmt; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmt; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscPercentCaption; DiscPercentCaptionLbl)
                        {
                        }
                        column(AmtCaption; AmtCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscOnVATCaption; PmtDiscOnVATCaptionLbl)
                        {
                        }
                        column(SalesLineDesc_SalesLineCaption; "Sales Invoice Line".FieldCaption(Description))
                        {
                        }
                        column(No_SalesLineCaption; "Sales Invoice Line".FieldCaption("No."))
                        {
                        }
                        column(Quantity_SalesLineCaption; "Sales Invoice Line".FieldCaption(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption; "Sales Invoice Line".FieldCaption("Unit of Measure"))
                        {
                        }
                        column(AllowInvDisc_SalesLineCaption; "Sales Invoice Line".FieldCaption("Allow Invoice Disc."))
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; "Sales Invoice Line".FieldCaption("VAT Identifier"))
                        {
                        }
                        column(Lot_No; ReservEntry."Lot No.")
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText_DimLoop2; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet then
                                        CurrReport.Break;
                                end else
                                    if not Continue then
                                        CurrReport.Break;

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break;

                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            column(AsmLineUnitOfMeasureText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent + AsmLine.Description)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineType; AsmLine.Type)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    AsmLine.FindSet
                                else
                                    AsmLine.Next;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break;
                                if not AsmInfoExistsForLine then
                                    CurrReport.Break;
                                AsmLine.SetRange("Document Type", AsmHeader."Document Type");
                                AsmLine.SetRange("Document No.", AsmHeader."No.");
                                SetRange(Number, 1, AsmLine.Count);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                SalesLine.Find('-')
                            else
                                SalesLine.Next;
                            "Sales Invoice Line" := SalesLine;
                            //IF DisplayAssemblyInformation THEN
                            //  AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);
                            if not "Sales Invoice Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Invoice Line"."No." := '';

                            NNC_SalesLineLineAmt += SalesLine."Line Amount";
                            NNC_SalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            NNC_TotalLCY := NNC_SalesLineLineAmt - NNC_SalesLineInvDiscAmt;

                            NNC_TotalExclVAT := NNC_TotalLCY;
                            NNC_VATAmt := VATAmount;
                            NNC_TotalInclVAT := NNC_TotalLCY - NNC_VATAmt;

                            NNC_PmtDiscOnVAT := -VATDiscountAmount;

                            NNC_TotalInclVAT2 := TotalAmountInclVAT;

                            NNC_VatAmt2 := VATAmount;
                            NNC_TotalExclVAT2 := VATBaseAmount;

                            //CBR_SS_15032018..>>
                            i := 0;
                            Clear(LotNo);
                            Clear(LotNoValue);
                            Clear(ExpDate);

                            ReservEntry.Reset;
                            ReservEntry.SetRange("Source ID", "Sales Invoice Line"."Document No.");
                            ReservEntry.SetRange("Source Ref. No.", "Sales Invoice Line"."Line No.");
                            ReservEntry.SetRange("Item No.", "Sales Invoice Line"."No.");
                            if ReservEntry.FindSet then
                                repeat
                                    i += 1;
                                    LotNo[i] := 'Lot No.: ' + ReservEntry."Lot No." + ' ' + ' Qty : ' + Format(Abs(ReservEntry.Quantity));

                                    if (LotNo[2] <> '') and (LotNo[2] <> LotNo[1]) then begin
                                        LotNoValue += ' , ' + 'Lot No.: ' + ReservEntry."Lot No." + ' ' + ' Qty : ' + Format(Abs(ReservEntry.Quantity));
                                        if ReservEntry."Expiration Date" <> 0D then
                                            ExpDate += Format(ReservEntry."Expiration Date")
                                        else
                                            ExpDate += GetExpirationDate(ReservEntry);

                                    end else begin
                                        if LotNoValue <> ReservEntry."Lot No." then begin
                                            if LotNoValue = '' then
                                                LotNoValue += 'Lot No.: ' + ReservEntry."Lot No." + ' ' + ' Qty : ' + Format(Abs(ReservEntry.Quantity))
                                            else
                                                LotNoValue += ' , ' + 'Lot No.: ' + ReservEntry."Lot No." + ' ' + ' Qty : ' + Format(Abs(ReservEntry.Quantity));

                                            if Format(ReservEntry."Expiration Date") <> '' then
                                                ExpDate += ' , ' + Format(ReservEntry."Expiration Date")
                                            else
                                                ExpDate += ' , ' + GetExpirationDate(ReservEntry);
                                        end;
                                    end;

                                until ReservEntry.Next = 0;

                            if LotNoValue = '' then begin
                                TracSpec.Reset;
                                TracSpec.SetRange("Source ID", "Sales Invoice Line"."Document No.");
                                TracSpec.SetRange("Source Ref. No.", "Sales Invoice Line"."Line No.");
                                TracSpec.SetRange("Item No.", "Sales Invoice Line"."No.");
                                if TracSpec.FindFirst then
                                    repeat
                                        i += 1;
                                        LotNo[i] := 'Lot No.: ' + TracSpec."Lot No." + ' ' + 'Qty : ' + Format(Abs(TracSpec."Quantity (Base)" / TracSpec."Qty. per Unit of Measure"));

                                        if LotNo[2] <> '' then begin
                                            if LotNoValue = '' then
                                                LotNoValue += 'Lot No.: ' + TracSpec."Lot No." + ' ' + 'Qty : ' + Format(Abs(TracSpec."Quantity (Base)" / TracSpec."Qty. per Unit of Measure"))
                                            else
                                                LotNoValue += ' , ' + 'Lot No.: ' + TracSpec."Lot No." + ' ' + 'Qty : ' + Format(Abs(TracSpec."Quantity (Base)" / TracSpec."Qty. per Unit of Measure"));
                                            if TracSpec."Expiration Date" <> 0D then
                                                ExpDate += ' , ' + Format(TracSpec."Expiration Date");
                                        end else begin
                                            LotNoValue += ' , ' + 'Lot No.: ' + TracSpec."Lot No." + ' ' + 'Qty : ' + Format(Abs(TracSpec."Quantity (Base)" / TracSpec."Qty. per Unit of Measure"));
                                            ExpDate += Format(TracSpec."Expiration Date");
                                        end;
                                    until TracSpec.Next = 0;
                            end;


                            if (LotNoValue <> '') and (ExpDate = '') then
                                LotNoValue := LotNoValue;

                            if ExpDate <> '' then
                                LotNoValue := LotNoValue + ' , ExpDate : ' + ExpDate;
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DeleteAll;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.Find('+');
                            while MoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                                  (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                                  (SalesLine.Amount = 0)
                            do
                                MoreLines := SalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break;
                            SalesLine.SetRange("Line No.", 0, SalesLine."Line No.");
                            SetRange(Number, 1, SalesLine.Count);
                            //CurrReport.CreateTotals(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(InvDiscBaseCaption; InvDiscBaseCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(VATIdentCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            // CurrReport.CreateTotals(
                            //   VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                            //   VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VAT_VATAmountLine; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATAmtLine; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Invoice Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount = 0)
                            then
                                CurrReport.Break;

                            SetRange(Number, 1, VATAmountLine.Count);
                            //CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesHeader; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break;
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        PrintOnlyIfDetail = true;
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText_PrepmtLoop; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText1_PrepmtLoop; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmt; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufAmtVATAmt; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtText_VATAmountLine; VATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(GLAccNoCaption; GLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            PrintOnlyIfDetail = true;
                            column(DimText_PrepmtDimLoop; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not TempPrepmtDimSetEntry.Find('-') then
                                        CurrReport.Break;
                                end else
                                    if not Continue then
                                        CurrReport.Break;

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText :=
                                          StrSubstNo('%1 %2', TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until TempPrepmtDimSetEntry.Next = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.Find('-') then
                                    CurrReport.Break;
                            end else
                                if PrepmtInvBuf.Next = 0 then
                                    CurrReport.Break;

                            if ShowInternalInfo then
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, PrepmtInvBuf."Dimension Set ID");

                            if "Sales Invoice Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;


                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        PrintOnlyIfDetail = true;
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdent; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepaymentVATAmtSpecCaption; PrepaymentVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, PrepmtVATAmountLine.Count);
                        end;
                    }
                    dataitem(PrepmtTotal; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        PrintOnlyIfDetail = true;

                        trigger OnPreDataItem()
                        begin
                            if not PrepmtInvBuf.Find('-') then
                                CurrReport.Break;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    VATAmountLine.DeleteAll;
                    SalesLine.DeleteAll;
                    //SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.CalcVATAmountLines("Sales Invoice Header", VATAmountLine);
                    //SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DeleteAll;
                    //SalesPostPrepmt.GetSalesLines("Sales Header",0,PrepmtSalesLine);

                    /*IF NOT PrepmtSalesLine.ISEMPTY THEN BEGIN
                      SalesPostPrepmt.GetSalesLinesToDeduct("Sales Header",TempSalesLine);
                      IF NOT TempSalesLine.ISEMPTY THEN
                        SalesPostPrepmt.CalcVATAmountLines("Sales Header",TempSalesLine,PrepmtVATAmountLineDeduct,1);
                    END;
                    SalesPostPrepmt.CalcVATAmountLines("Sales Header",PrepmtSalesLine,PrepmtVATAmountLine,0);
                    PrepmtVATAmountLine.DeductVATAmountLine(PrepmtVATAmountLineDeduct);
                    SalesPostPrepmt.UpdateVATOnLines("Sales Header",PrepmtSalesLine,PrepmtVATAmountLine,0);
                    SalesPostPrepmt.BuildInvLineBuffer2("Sales Header",PrepmtSalesLine,0,PrepmtInvBuf);*/
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
                    //CurrReport.PageNo := 1;

                    NNC_TotalLCY := 0;
                    NNC_TotalExclVAT := 0;
                    NNC_VATAmt := 0;
                    NNC_TotalInclVAT := 0;
                    NNC_PmtDiscOnVAT := 0;
                    NNC_TotalInclVAT2 := 0;
                    NNC_VatAmt2 := 0;
                    NNC_TotalExclVAT2 := 0;
                    NNC_SalesLineLineAmt := 0;
                    NNC_SalesLineInvDiscAmt := 0;

                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", "Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                FormatAddressFields("Sales Invoice Header");
                FormatDocumentFields("Sales Invoice Header");

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if Print then begin
                    //IF CurrReport.USEREQUESTPAGE AND ArchiveDocument OR
                    // NOT CurrReport.USEREQUESTPAGE AND SalesSetup."Archive Quotes and Orders"
                    // THEN
                    //  ArchiveManagement.StoreSalesDocument("Sales Invoice Header",LogInteraction);

                    /*  IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                          SegManagement.LogDocument(
                            SegManagement.SalesOrderConfirmInterDocType,"No.","Doc. No. Occurrence",
                            "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No."
                            ,"Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                        ELSE
                          SegManagement.LogDocument(
                            SegManagement.SalesOrderConfirmInterDocType,"No.","Doc. No. Occurrence",
                            "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                            "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                      END;*/
                end;

            end;

            trigger OnPreDataItem()
            begin
                Print := Print or not CurrReport.Preview;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := SalesSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    var
        Text004: Label 'Order Confirmation %1', Comment = '%1 = Document No.';
        PageCaptionCap: Label 'Page %1 of %2';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Invoice Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatDocument: Codeunit "Format Document";
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'Tax Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        NNC_TotalLCY: Decimal;
        NNC_TotalExclVAT: Decimal;
        NNC_VATAmt: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_PmtDiscOnVAT: Decimal;
        NNC_TotalInclVAT2: Decimal;
        NNC_VatAmt2: Decimal;
        NNC_TotalExclVAT2: Decimal;
        NNC_SalesLineLineAmt: Decimal;
        NNC_SalesLineInvDiscAmt: Decimal;
        Print: Boolean;
        Cust: Record Customer;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        OrderNoCaptionLbl: Label 'Order No.';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscPercentCaptionLbl: Label 'Discount %';
        AmtCaptionLbl: Label 'Amount';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PmtDiscOnVATCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        VATPercentCaptionLbl: Label 'Tax %';
        VATBaseCaptionLbl: Label 'Tax Base';
        VATAmtCaptionLbl: Label 'Tax Amount';
        VATAmtSpecCaptionLbl: Label 'Tax Amount Specification';
        InvDiscBaseCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        VATIdentCaptionLbl: Label 'Tax Identifier';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        DescriptionCaptionLbl: Label 'Description';
        GLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepaymentVATAmtSpecCaptionLbl: Label 'Prepayment Tax Amount Specification';
        PmtTermsDescCaptionLbl: Label 'Payment Terms';
        ShpMethodDescCaptionLbl: Label 'Shipment Method';
        PrepmtPmtTermsDescCaptionLbl: Label 'Prepayment Payment Terms';
        DocDateCaptionLbl: Label 'Document Date';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
        HomePageCaptionLbl: Label 'HomePage';
        EmailCaptionLbl: Label 'E-Mail';
        ReservEntry: Record "Reservation Entry";
        Tot: Decimal;
        TracSpec: Record "Tracking Specification";
        LotNo: array[20] of Text;
        i: Integer;
        LotNoValue: Text;
        ExpDate: Text;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Rowid: Text[250];
        ValueEntryRelation: Record "Value Entry Relation";
        ValueEntry: Record "Value Entry";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        Qty: Text;
        CommentTextArray: array[20] of Text[250];
        SalInvLine: Record "Sales Invoice Line";


    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatAddressFields(var SalesInvHeader: Record "Sales Invoice Header")
    begin
        FormatAddr.GetCompanyAddr(SalesInvHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvSellTo(CustAddr, SalesInvHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvHeader);
    end;

    local procedure FormatDocumentFields(SalesInvHeader: Record "Sales Invoice Header")
    begin
        with SalesInvHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FieldCaption("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FieldCaption("VAT Registration No."));
        end;
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    local procedure GetExpirationDate(ReservationEntry: Record "Reservation Entry"): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange("Item No.", ReservationEntry."Item No.");
        ItemLedgerEntry.SetRange("Lot No.", ReservationEntry."Lot No.");
        if ItemLedgerEntry.FindFirst then
            exit(Format(ItemLedgerEntry."Expiration Date"));
    end;
}

