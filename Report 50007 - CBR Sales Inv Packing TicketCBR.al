report 50007 "CBR Sales Inv Packing Ticket"
{

    Caption = 'Sales Inv Packing Ticket';
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = Normal;
    // CBR_SS : 02/03/2018 : Added code to display Lot No.
    RDLCLayout = './SalesInvPackingTicketCBR.rdl';
    WordLayout = './SalesInvPackingTicketCBR.docx';
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(BillToAddress2CBR; Header."Bill-to Address 2")
            {
            }
            column(BillToAddressCBR; Header."Bill-to Address")
            {
            }
            column(BillToCityCBR; Header."Bill-to City")
            {
            }
            column(BillToContactCBR; Header."Bill-to Contact")
            {
            }
            column(BillToCountryCBR; Header."Bill-to Country/Region Code")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BillToStateCBR; Header."Bill-to County")
            {
            }
            column(BillToZipCBR; Header."Bill-to Post Code")
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfoCounty; CompanyInfo.County)
            {
            }
            column(CompanyInfoEmail; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoRegionCode; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyInfoZipCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
            }
            column(CompanyLegalStatement; GetLegalStatement)
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(CustomerPONumber; "External Document No.")
            {
            }
            column(CustomerPONumber_Lbl; CustomerPONumberLbl)
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            column(DocumentCopyText; StrSubstNo(DocumentCaption, CopyText))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(DocumentTitle_Lbl; SalesInvoiceLbl)
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber)
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl)
            {
            }
            column(HomePage_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType)
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(OrderDate_Lbl; FieldCaption("Order Date"))
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderNo_Lbl; FieldCaption("Order No."))
            {
            }
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PackageTrackingNo_Lbl; FieldCaption("Package Tracking No."))
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(PaymentReference; GetPaymentReference)
            {
            }
            column(PaymentReference_Lbl; GetPaymentReferenceLbl)
            {
            }
            column(PaymentTermsCode; PaymentTerms.Code)
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(Salesperson_Lbl2; SalespersonLbl2)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code"))
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(SubTotAmt; SubTotAmt)
            {
            }
            column(TaxTotAmt; TaxTotAmt)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
            }
            column(YourReference_Header; "Your Reference")
            {
            }
            column(YourReference_Header_Lbl; FieldCaption("Your Reference"))
            {
            }
            dataitem(SalInvLine; "Sales Invoice Line")
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
                    SalInvLine.Get("Document No.", "Line No.");
                    SalInvLine.SetFilter(Description, '<>%1', '');
                    SalInvLine.SetFilter("No.", '=%1', '');
                    SalInvLine.SetFilter(Quantity, '=%1', 0);
                    i := 0;
                    if SalInvLine.FindSet then
                        repeat
                            i := i + 1;
                            if i <= 5 then
                                CommentTextArray[i] := SalInvLine.Description;
                        until SalInvLine.Next = 0;
                    //CBR_SS --
                end;
            }
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0));
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(Description2_CBR; Line."Description 2")
                {
                }
                column(Description2_Line; Line."Description 2")
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(JobNo; JobNo)
                {
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                }
                column(JobTaskNo; JobTaskNo)
                {
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                }
                column(LineAmount_Lbl; LineAmountLbl)
                {
                }
                column(LineAmount_Line; "Line Amount")
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineNo_Line; "Line No.")
                {
                }
                column(LineTotalnoTax; Amount)
                {
                }
                column(LineTotalwithTax; "Amount Including VAT")
                {
                }
                column(OrgQty; OrgQty)
                {
                }
                column(Quantity_Line; Quantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Quantity_Line_Lbl2; OrderQuantityLbl)
                {
                }
                column(ShipmentDate_Line; Format(PostedShipmentDate))
                {
                }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(Type_Line; Format(Type))
                {
                }
                column(Unit_Lbl; UnitLbl)
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(UnitPrice; "Unit Price")
                {
                    AutoFormatExpression = GetCurrencyCode;
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitPrice_Lbl2; UnitPriceLbl)
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; "VAT %")
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No."), "Item No." = FIELD("No.");
                    DataItemLinkReference = Line;
                    DataItemTableView = SORTING("Entry No.");
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Item Ledger Entry No.");
                        DataItemTableView = SORTING("Entry No.");
                        column(CountVar; CountVar)
                        {
                        }
                        column(CountVar1; CountVar1)
                        {
                        }
                        column(Expire_Date; "Item Ledger Entry"."Expiration Date")
                        {
                        }
                        column(Lot_No; "Item Ledger Entry"."Lot No.")
                        {
                        }
                        column(QtyPerUnitMeasure; "Item Ledger Entry"."Qty. per Unit of Measure")
                        {
                        }
                        column(Quantity; "Item Ledger Entry".Quantity)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //CBR_SS_02032018..>>
                            if "Item Ledger Entry"."Lot No." <> '' then
                                CountVar += 1;
                            //CBR_SS_02032018..<<
                        end;

                        trigger OnPreDataItem()
                        begin
                            CountVar := 0;      //CBR_SS_02032018
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CountVar1 += 1;         //CBR_SS_02032018
                    end;

                    trigger OnPreDataItem()
                    begin
                        CountVar1 := 0;       //CBR_SS_02032018
                    end;
                }
                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    UseTemporary = true;
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {

                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {

                    }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                        ValueEntryEnum: Enum "Item Ledger Document Type";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break;
                        GetAssemblyLinesForDocument(
                          AssemblyLine, 7, Line."Document No.", Line."Line No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    PostedShipmentDate := 0D;
                    if Quantity <> 0 then
                        PostedShipmentDate := FindPostedShipmentDate;

                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

                    VATAmountLine.Init;
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    VATAmountLine.InsertLine;

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FirstLineHasBeenOutput then
                        Clear(CompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    if JobTaskNo <> '' then begin
                        JobTaskNoLbl := JobTaskNoLbl2;
                        JobTaskDescription := GetJobTaskDescription(JobNo, JobTaskNo);
                    end else begin
                        JobTaskDescription := '';
                        JobTaskNoLbl := '';
                    end;

                    if JobNo <> '' then
                        JobNoLbl := JobNoLbl2
                    else
                        JobNoLbl := '';

                    //CBR_SS_02032017..>>
                    OrgQty := SalesOrderOriginalQty(Header."Order No.", Line."Line No.", Line."No.");
                    //CBR_SS_02032017..<<
                end;

                trigger OnPreDataItem()
                var
                    EnvironmentInfo: Codeunit "Environment Information";
                begin
                    VATAmountLine.DeleteAll;
                    VATClauseLine.DeleteAll;
                    ShipmentLine.Reset;
                    ShipmentLine.DeleteAll;
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break;
                    SetRange("Line No.", 0, "Line No.");
                    //CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    CompanyInfo.CalcFields(Picture);
                    if ("Job No." <> '') and (not EnvironmentInfo.IsSaaS) then
                        JobNo := ''
                    else
                        JobNo := "Job No.";
                    if ("Job Task No." <> '') and (not EnvironmentInfo.IsSaaS) then
                        JobTaskNo := ''
                    else
                        JobTaskNo := "Job Task No.";
                end;
            }
            dataitem(WorkDescriptionLines; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 99999));
                column(WorkDescriptionLine; WorkDescriptionLine)
                {
                }
                column(WorkDescriptionLineNumber; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if WorkDescriptionInstream.EOS then
                        CurrReport.Break();
                    WorkDescriptionInstream.ReadText(WorkDescriptionLine);
                end;

                trigger OnPostDataItem()
                begin
                    Clear(WorkDescriptionInstream)
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowWorkDescription then
                        CurrReport.Break();
                    Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                end;
            }
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(NoOfVATIdentifiers; Count)
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Line.GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;

                    if "VAT Clause Code" <> '' then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert then;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    // CurrReport.CreateTotals(
                    //   "Line Amount", "Inv. Disc. Base Amount",
                    //   "Invoice Discount Amount", "VAT Base", "VAT Amount",
                    //   VATBaseLCY, VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                UseTemporary = true;
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClause.Description)
                {
                }
                column(Description2_VATClauseLine; VATClause."Description 2")
                {
                }
                column(NoOfVATClauses; Count)
                {
                }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.Skip;
                    if not VATClause.Get("VAT Clause Code") then
                        CurrReport.Skip;
                    VATClause.TranslateDescription(Header."Language Code");
                end;
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Amount_ReportTotalsLine; Amount)
                {
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                }
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateReportTotalLines;
                end;
            }
            dataitem(USReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = SORTING("Line No.");
                UseTemporary = true;
                column(Amount_USReportTotalsLine; Amount)
                {
                }
                column(AmountFormatted_USReportTotalsLine; "Amount Formatted")
                {
                }
                column(Description_USReportTotalsLine; Description)
                {
                }
                column(FontBold_USReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_USReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    CreateUSReportTotalLines;
                end;
            }
            dataitem(LineFee; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));
                column(LineFeeCaptionText; TempLineFeeNoteOnReportHist.ReportText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not DisplayAdditionalFeeNote then
                        CurrReport.Break;

                    if Number = 1 then begin
                        if not TempLineFeeNoteOnReportHist.FindSet then
                            CurrReport.Break
                    end else
                        if TempLineFeeNoteOnReportHist.Next = 0 then
                            CurrReport.Break;
                end;
            }
            dataitem(PaymentReportingArgument; "Payment Reporting Argument")
            {
                DataItemTableView = SORTING(Key);
                UseTemporary = true;
                column(PaymentServiceLogo; Logo)
                {
                }
                column(PaymentServiceLogo_Url; GetTargetURL)
                {
                }
                column(PaymentServiceLogo_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceText_Url; GetTargetURL)
                {
                }
                column(PaymentServiceText_UrlText; "URL Caption")
                {
                }
            }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name)
                {
                }
                column(LeftHeaderValue; Value)
                {
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(RightHeaderName; Name)
                {
                }
                column(RightHeaderValue; Value)
                {
                }
            }
            dataitem(LetterText; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(BodyText; BodyLbl)
                {
                }
                column(ClosingText; ClosingLbl)
                {
                }
                column(GreetingText; GreetingLbl)
                {
                }
                column(PmtDiscText; PmtDiscText)
                {
                }

                trigger OnPreDataItem()
                begin
                    PmtDiscText := '';
                    if Header."Payment Discount %" <> 0 then
                        PmtDiscText := StrSubstNo(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(AmountExemptFromSalesTax; VATAmountLine.GetAmtExemptFromSalesTax)
                {
                }
                column(AmountExemptFromSalesTaxLbl; AmtExemptfromSalesTaxLbl)
                {
                }
                column(AmountSubjectToSalesTax; VATAmountLine.GetAmtSubjectToSalesTax)
                {
                }
                column(AmountSubjectToSalesTaxLbl; AmtSubjecttoSalesTaxLbl)
                {
                }
                column(TotalAmountExclInclVAT; TotalAmountExclInclVATValue)
                {
                }
                column(TotalAmountExclInclVATText; TotalAmountExclInclVATTextValue)
                {
                }
                column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalExcludingVATText; TotalExclVATText)
                {
                }
                column(TotalIncludingVATText; TotalInclVATText)
                {
                }
                column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalNetAmount; TotalAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmountLCY; TotalVATAmountLCY)
                {
                }
                column(TotalVATAmountText; VATAmountLine.VATAmountText)
                {
                }
                column(TotalVATBaseLCY; TotalVATBaseLCY)
                {
                }

                trigger OnPreDataItem()
                begin
                    if Header."Prices Including VAT" then begin
                        TotalAmountExclInclVATTextValue := TotalExclVATText;
                        TotalAmountExclInclVATValue := TotalAmount;
                    end else begin
                        TotalAmountExclInclVATTextValue := TotalInclVATText;
                        TotalAmountExclInclVATValue := TotalAmountInclVAT;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                PaymentServiceSetup: Record "Payment Service Setup";
            begin
                FillLeftHeader;
                FillRightHeader;

                if not CurrReport.Preview then
                    CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", Header);

                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                FormatAddressFields(Header);
                FormatDocumentFields(Header);

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                GetLineFeeNoteOnReportHist("No.");

                if LogInteraction and not CurrReport.Preview then begin
                    if "Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');
                end;

                PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, Header);

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;


                //CBR_SS_02032018..>>
                RecSalesInvLine.Reset;
                RecSalesInvLine.SetRange("Document No.", "No.");
                if RecSalesInvLine.FindSet then
                    repeat
                        SubTotAmt += RecSalesInvLine."Line Amount";
                        TaxTotAmt += RecSalesInvLine."Amount Including VAT" - RecSalesInvLine.Amount;
                    until RecSalesInvLine.Next = 0;
                //CBR_SS_02032018..<<
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
                SubTotAmt := 0;     //CBR_SS_02032018
                TaxTotAmt := 0;     //CBR_SS_02032018
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
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                    }
                    field(DisplayShipmentInformation; DisplayShipmentInformation)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Shipments';
                        ToolTip = 'Specifies that shipments are shown on the document.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
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
            InitLogInteraction;
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
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction;

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        SalesInvoiceNoLbl: Label 'Sales - Invoice %1';
        SalespersonLbl: Label 'Sales person';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'Tax Amount Specification';
        VATAmtLbl: Label 'Tax Amount';
        VATAmountLCYLbl: Label 'Tax Amount ($)';
        VATBaseLbl: Label 'Tax Base';
        VATBaseLCYLbl: Label 'Tax Base ($)';
        VATClausesLbl: Label 'Tax Clause';
        VATIdentifierLbl: Label 'Tax Identifier';
        VATPercentageLbl: Label 'Tax %';
        //TempBlobWorkDescription: Record TempBlob;

        WorkDescriptionInstream: InStream;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        VATClause: Record "VAT Clause";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        JobNo: Code[20];
        JobTaskNo: Code[20];
        PostedShipmentDate: Date;
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        PmtDiscText: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        TotalAmountExclInclVATTextValue: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        LogInteraction: Boolean;
        SalesPrepInvoiceNoLbl: Label 'Sales - Prepayment Invoice %1';
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        AmtSubjecttoSalesTaxLbl: Label 'Amount Subject to Sales Tax';
        AmtExemptfromSalesTaxLbl: Label 'Amount Exempt from Sales Tax';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        TotalAmountExclInclVATValue: Decimal;
        DisplayAdditionalFeeNote: Boolean;
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.';
        SalespersonLbl2: Label 'Salesperson';
        JobNoLbl2: Label 'Job No.';
        JobTaskNoLbl2: Label 'Job Task No.';
        JobTaskDescription: Text[50];
        JobTaskDescLbl: Label 'Job Task Description';
        OrderQuantityLbl: Label 'Order Quantity';
        TaxLbl: Label 'Tax';
        CustomerPONumberLbl: Label 'Customer PO No.';
        UnitLbl: Label 'Unit';
        UnitPriceLbl: Label 'Unit Price';
        LineAmountLbl: Label 'Line Amount';
        ItemLedgerEntry: Record "Item Ledger Entry";
        CountVar: Integer;
        SubTotAmt: Decimal;
        RecSalesInvLine: Record "Sales Invoice Line";
        TaxTotAmt: Decimal;
        CountVar1: Integer;
        OrgQty: Decimal;
        i: Integer;
        CommentTextArray: array[20] of Text[250];


    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure "//CBR_SS"()
    begin
    end;

    local procedure CreateReportTotalLines()
    var
        TempSalesTaxAmountLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
    begin
        ReportTotalsLine.DeleteAll;
        if Header."Tax Area Code" <> '' then
            if TaxArea.Get(Header."Tax Area Code") then;
        if (Header."Tax Area Code" = '') or (TaxArea."Country/Region" = TaxArea."Country/Region"::US) then begin
            CreateUSReportTotalLines;
            exit;
        end;

        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;

        if TotalAmountVAT <> 0 then begin
            GetTaxSummarizedLines(TempSalesTaxAmountLine);
            TempSalesTaxAmountLine.SetCurrentKey("Print Order");
            TempSalesTaxAmountLine.Ascending(true);
            if TempSalesTaxAmountLine.FindSet then
                repeat
                    ReportTotalsLine.Add(TempSalesTaxAmountLine."Print Description", TempSalesTaxAmountLine."Tax Amount", false, true, false);
                until TempSalesTaxAmountLine.Next = 0;
        end;
    end;

    local procedure CreateUSReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll;
        ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
        ReportTotalsLine.Add(StrSubstNo('%1 %2', TotalLbl, TaxLbl), TotalAmountVAT, false, true, false);
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        if Header."Prepayment Invoice" then
            exit(SalesPrepInvoiceNoLbl);
        exit(SalesInvoiceNoLbl);
    end;

    local procedure FillLeftHeader()
    begin
        LeftHeader.DeleteAll;

        FillNameValueTable(LeftHeader, Header.FieldCaption("Your Reference"), Header."Your Reference");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl, Header.GetCustomerVATRegistrationNumber);
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl, Header.GetCustomerGlobalLocationNumber);
        FillNameValueTable(LeftHeader, InvNoLbl, Header."No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl, PaymentTerms.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl, PaymentMethod.Description);
        FillNameValueTable(LeftHeader, Cust.GetLegalEntityTypeLbl, Cust.GetLegalEntityType);
        FillNameValueTable(LeftHeader, ShptMethodDescLbl, ShipmentMethod.Description);
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init;
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert;
        end;
    end;

    local procedure FillRightHeader()
    begin
        RightHeader.DeleteAll;

        FillNameValueTable(RightHeader, EMailLbl, CompanyInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl, CompanyInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl, CompanyInfo."Phone No.");
        FillNameValueTable(RightHeader, CompanyInfo.GetRegistrationNumberLbl, CompanyInfo.GetRegistrationNumber);
        FillNameValueTable(RightHeader, CompanyInfo.GetVATRegistrationNumberLbl, CompanyInfo.GetVATRegistrationNumber);
        FillNameValueTable(RightHeader, CompanyInfoBankNameLbl, CompanyInfo."Bank Name");
        FillNameValueTable(RightHeader, CompanyInfoGiroNoLbl, CompanyInfo."Giro No.");
        FillNameValueTable(RightHeader, CompanyInfo.FieldCaption(IBAN), CompanyInfo.IBAN);
        FillNameValueTable(RightHeader, CompanyInfo.FieldCaption("SWIFT Code"), CompanyInfo."SWIFT Code");
        FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl, Header.GetPaymentReference);
    end;

    local procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer";
    begin
        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.Get(Line."Shipment No.") then
                exit(SalesShipmentHeader."Posting Date");

        if Line.Type = Line.Type::" " then
            exit(0D);

        ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.Reset;
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if ShipmentLine.Find('-') then begin
            SalesShipmentBuffer2 := ShipmentLine;
            if not DisplayShipmentInformation then
                if ShipmentLine.Next = 0 then begin
                    ShipmentLine.Get(
                      SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                    ShipmentLine.Delete;
                    exit(SalesShipmentBuffer2."Posting Date");
                end;
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll;
                exit(Header."Posting Date");
            end;
        end;
        exit(Header."Posting Date");
    end;

    local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        with SalesInvoiceHeader do begin
            FormatDocument.SetTotalLabels(GetCurrencySymbol, TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    local procedure GetJobTaskDescription(JobNo: Code[20]; JobTaskNo: Code[20]): Text[50]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SetRange("Job No.", JobNo);
        JobTask.SetRange("Job Task No.", JobTaskNo);
        if JobTask.FindFirst then
            exit(JobTask.Description);

        exit('');
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll;
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet then begin
            repeat
                TempLineFeeNoteOnReportHist.Init;
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert;
            until LineFeeNoteOnReportHist.Next = 0;
        end else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode);
            if LineFeeNoteOnReportHist.FindSet then
                repeat
                    TempLineFeeNoteOnReportHist.Init;
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert;
                until LineFeeNoteOnReportHist.Next = 0;
        end;
    end;

    local procedure GetTaxSummarizedLines(var TempSalesTaxAmountLine: Record "Sales Tax Amount Line" temporary)
    var
        TaxArea: Record "Tax Area";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
    begin
        if not TaxArea.Get(Header."Tax Area Code") then
            exit;
        TempSalesTaxAmountLine.DeleteAll;
        SalesTaxCalculate.StartSalesTaxCalculation;
        if TaxArea."Use External Tax Engine" then
            SalesTaxCalculate.CallExternalTaxEngineForDoc(DATABASE::"Sales Invoice Header", 0, Header."No.")
        else begin
            SalesTaxCalculate.AddSalesInvoiceLines(Header."No.");
            SalesTaxCalculate.EndSalesTaxCalculation(Header."Posting Date");
        end;
        SalesTaxCalculate.GetSalesTaxAmountLineTable(TempSalesTaxAmountLine);
        SalesTaxCalculate.GetSummarizedSalesTaxTable(TempSalesTaxAmountLine);
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure SalesOrderOriginalQty(DocNo: Code[20]; LineNo: Integer; ItemNo: Code[20]): Decimal
    var
        RecSalesLine: Record "Sales Line";
    begin
        //CBR_SS_02032017..>>
        RecSalesLine.Reset;
        RecSalesLine.SetRange("Document No.", DocNo);
        RecSalesLine.SetRange("Line No.", LineNo);
        RecSalesLine.SetRange("No.", ItemNo);
        if RecSalesLine.FindFirst then
            exit(RecSalesLine.Quantity);
        //CBR_SS_02032017..<<
    end;
}

