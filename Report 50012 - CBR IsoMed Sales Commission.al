report 50012 "IsoMed Sales Commission"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IsoMedSalesCommission.rdl';

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Salesperson Code" = FIELD(Code);
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Posting Date", "Salesperson Code";
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE("No." = FILTER(<> 'ZZ*'), Quantity = FILTER(<> 0));
                    column(No_SalesInvoiceHeader; SalesInvoiceHeader."Order No.")
                    {
                    }
                    column(SelltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Sell-to Customer No.")
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                    {
                    }
                    column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                    {
                    }
                    column(ShipmentDate_SalesInvoiceLine; "Sales Invoice Line"."Shipment Date")
                    {
                    }
                    column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                    {
                    }
                    column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(UnitCostLCY_SalesInvoiceLine; "Sales Invoice Line"."Unit Cost (LCY)")
                    {
                    }
                    column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                    {
                    }
                    column(BilltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvoiceLine; "Sales Invoice Line"."Posting Date")
                    {
                    }
                    column(QtyperUnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Qty. per Unit of Measure")
                    {
                    }
                    column(UnitofMeasureCode_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure Code")
                    {
                    }
                    column(InvDate; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(OrderDate; "Sales Invoice Header"."Order Date")
                    {
                    }
                    column(SalesType; SalesType)
                    {
                    }
                    column(ShipToName; "Sales Invoice Header"."Ship-to Name")
                    {
                    }
                    column(ShipToAddr; "Sales Invoice Header"."Ship-to Address")
                    {
                    }
                    column(ShipToAddr2; "Sales Invoice Header"."Ship-to Address 2")
                    {
                    }
                    column(ShipToCity; "Sales Invoice Header"."Ship-to City")
                    {
                    }
                    column(ShipToState; SalesInvoiceHeader."Sell-to County")
                    {
                    }
                    column(ZIP; ZIP)
                    {
                    }
                    column(Currency; "Sales Invoice Header"."Currency Code")
                    {
                    }
                    column(SalesPerson; "Sales Invoice Header"."Salesperson Code")
                    {
                    }
                    column(Commission_SalesPurchaser; "Salesperson/Purchaser"."Commission %")
                    {
                    }
                    column(Customer_Lbl; Customer_Lbl)
                    {
                    }
                    column(Doc_Lbl; Doc_Lbl)
                    {
                    }
                    column(InvNo_Lbl; InvNo_Lbl)
                    {
                    }
                    column(InvDate_Lbl; InvDate_Lbl)
                    {
                    }
                    column(SalesType_Lbl; SalesType_Lbl)
                    {
                    }
                    column(Shippinzone_Lbl; Shippinzone_Lbl)
                    {
                    }
                    column(ItemNo_Lbl; ItemNo_Lbl)
                    {
                    }
                    column(Description_Lbl; Description_Lbl)
                    {
                    }
                    column(Shipped_Lbl; Shipped_Lbl)
                    {
                    }
                    column(UnitPrice_Lbl; UnitPrice_Lbl)
                    {
                    }
                    column(ExtPrice_Lbl; ExtPrice_Lbl)
                    {
                    }
                    column(Curr_Lbl; Curr_Lbl)
                    {
                    }
                    column(BaseUnitPrice_Lbl; BaseUnitPrice_Lbl)
                    {
                    }
                    column(BaseExtPrice_Lbl; BaseExtPrice_Lbl)
                    {
                    }
                    column(UnitCost_Lbl; UnitCost_Lbl)
                    {
                    }
                    column(ExtCost_Lbl; ExtCost_Lbl)
                    {
                    }
                    column(Margin_Lbl; Margin_Lbl)
                    {
                    }
                    column(MarginPer_Lbl; MarginPer_Lbl)
                    {
                    }
                    column(Cust_Lbl; Cust_Lbl)
                    {
                    }
                    column(UOM_Lbl; UOM_Lbl)
                    {
                    }
                    column(ShipToName_Lbl; ShipToName_Lbl)
                    {
                    }
                    column(ShipToAddr_Lbl; ShipToAddr_Lbl)
                    {
                    }
                    column(ShipToAddr2_Lbl; ShipToAddr2_Lbl)
                    {
                    }
                    column(ShipCity_Lbl; ShipCity_Lbl)
                    {
                    }
                    column(ShipState_Lbl; ShipState_Lbl)
                    {
                    }
                    column(Zip_Lbl; Zip_Lbl)
                    {
                    }
                    column(AdminCodeLbl; AdminCodeLbl)
                    {
                    }
                    column(AdminFeePercLbl; AdminFeePercLbl)
                    {
                    }
                    column(AdminFeeRateLbl; AdminFeeRateLbl)
                    {
                    }
                    column(SalespersonCaption; SalespersonCaption)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaption)
                    {
                    }
                    column(UnitcostVal; UnitcostVal)
                    {
                    }
                    column(ExtPriceVal; ExtPriceVal)
                    {
                    }
                    column(BaseExtPriceVal; BaseExtPriceVal)
                    {
                    }
                    column(ExtCostVal; ExtCostVal)
                    {
                    }
                    column(MarginVal; MarginVal)
                    {
                    }
                    column(MarginPerVal; MarginPerVal)
                    {
                    }
                    column(Commission; Commission)
                    {
                    }
                    column(AdminCode; AdminCode)
                    {
                    }
                    column(AdminFee; AdminFee)
                    {
                    }
                    column(AdminFeePer; AdminFeePer)
                    {
                    }
                    dataitem(Item; Item)
                    {
                        DataItemLink = "No." = FIELD("No.");
                        DataItemTableView = SORTING("No.");
                        column(UnitPrice_Item; Item."Unit Price")
                        {
                        }
                        column(UnitCost_Item; Item."Unit Cost")
                        {
                        }
                        column(UnitCostCommission; Item.CBRUnitCostCommission)
                        {
                        }
                        column(LastPurchaseCost_Item; Item."Last Direct Cost")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Clear(UnitcostVal);
                        Clear(ExtPriceVal);
                        Clear(BaseExtPriceVal);
                        Clear(ExtCostVal);
                        Clear(MarginVal);
                        Clear(MarginPerVal);
                        Clear(Commission);
                        Clear(SalesAmnt);


                        if SalesInvoiceHeader.Get("Document No.") then begin
                            SalesType := 'CUST';
                            if Customer.Get("Sales Invoice Line"."Sell-to Customer No.") then
                                ZIP := Customer."Post Code";
                        end;

                        //------------
                        case "Sales Invoice Line".Type of
                            "Sales Invoice Line".Type::"Charge (Item)":
                                begin
                                    UnitcostVal := "Sales Invoice Line"."Unit Cost";
                                end;
                            "Sales Invoice Line".Type::"Fixed Asset":
                                begin
                                    UnitcostVal := "Sales Invoice Line"."Unit Cost";
                                end;
                            "Sales Invoice Line".Type::"G/L Account":
                                begin
                                    UnitcostVal := "Sales Invoice Line"."Unit Cost";
                                end;
                            "Sales Invoice Line".Type::Item:
                                begin
                                    if "Sales Invoice Line"."Unit Cost" <> 9999 then begin //Modified by CBR to always be executed, not just when zero
                                        if Item.Get("Sales Invoice Line"."No.") then;
                                        //UnitcostVal := Item."Unit Cost" * "Sales Invoice Line"."Qty. per Unit of Measure"; //Modified by CBR to multiple by UoFM
                                        if Item.CBRUnitCostCommission > 0 then
                                            UnitcostVal := Item.CBRUnitCostCommission * "Sales Invoice Line"."Qty. per Unit of Measure"
                                        else
                                            UnitcostVal := Item."Unit Cost" * "Sales Invoice Line"."Qty. per Unit of Measure"; //Added by CBR
                                                                                                                               // UnitcostVal := "Sales Invoice Line"."Unit Cost"; Removed b CBR to alwys use Item Unit Cost
                                    end;
                                end;
                            "Sales Invoice Line".Type::Resource:
                                begin
                                    if "Sales Invoice Line"."Unit Cost" = 0 then begin
                                        if Resource.Get("Sales Invoice Line"."No.") then
                                            UnitcostVal := Resource."Unit Cost";
                                    end else
                                        UnitcostVal := "Sales Invoice Line"."Unit Cost";
                                end;
                        end;
                        //------------



                        if Item.Get("Sales Invoice Line"."No.") then
                            BaseExtPriceVal := "Sales Invoice Line".Quantity * Item."Unit Price";

                        Commission := 10;

                        ExtPriceVal := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";

                        ExtCostVal := "Sales Invoice Line".Quantity * UnitcostVal;

                        //CBR_SS 11/04/2018 >>
                        //i :=0;
                        Clear(AdminCode);
                        Clear(AdminFee);
                        Clear(AdminFeePer);
                        Clear(SalesAmnt);
                        // recSalesPrice.RESET;
                        // recSalesPrice.SETRANGE("Item No.","Sales Invoice Line"."No.");
                        // recSalesPrice.SETRANGE("Sales Type",recSalesPrice."Sales Type"::"Customer Price Group");
                        // recSalesPrice.SETRANGE("Sales Code","Sales Invoice Line"."Customer Price Group");
                        // IF NOT recSalesPrice.FINDFIRST THEN
                        //  CurrReport.SKIP;

                        recSalesPrice.Reset;
                        recSalesPrice.SetRange("Item No.", "Sales Invoice Line"."No.");
                        recSalesPrice.SetRange("Sales Type", recSalesPrice."Sales Type"::"Customer Price Group");
                        recSalesPrice.SetRange("Sales Code", "Sales Invoice Line"."Customer Price Group");
                        if recSalesPrice.FindFirst then begin
                            if (recSalesPrice."Sales Code" = 'CPS') or (recSalesPrice."Sales Code" = 'BANNER HEA') then begin
                                AdminCode := "Sales Invoice Line"."Customer Price Group";
                                SalesAmnt := ExtPriceVal;
                                AdminFeePer := 3;
                                AdminFee := (SalesAmnt * AdminFeePer) / 100;
                                //i +=1;
                            end else
                                if (recSalesPrice."Sales Code" = 'VIZIENT') or (recSalesPrice."Sales Code" = 'INTALERE') then begin
                                    AdminCode := "Sales Invoice Line"."Customer Price Group";
                                    SalesAmnt := ExtPriceVal;
                                    AdminFeePer := 5;
                                    AdminFee := (SalesAmnt * AdminFeePer) / 100;
                                end;
                        end;
                        //CBR_SS 11/04/2018 <<

                        MarginVal := ExtPriceVal - ExtCostVal - AdminFee;

                        if (ExtPriceVal <> 0) then
                            MarginPerVal := (MarginVal / ExtPriceVal) * 100;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SalespersonFilter := '';
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Salespers./Purch. Code" <> '' then
                            SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code")
                        else begin
                            SalespersonFilter := GetFilter("Salesperson Code");
                            if SalespersonFilter <> '' then
                                SetRange("Salesperson Code", SalespersonFilter)
                            else
                                Error('Please select the Salesperson Code first')
                        end
                    end
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
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
        Clear(SalesType);
        Clear(ZIP);

        // IF "Sales Invoice Header".GETFILTER("Salesperson Code") = '' THEN
        //  ERROR('Please Select Salesperson Code');
    end;

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer_Lbl: Label 'Customer';
        Doc_Lbl: Label 'Document No.';
        InvNo_Lbl: Label 'Invoice No.';
        InvDate_Lbl: Label 'Invoice Date';
        SalesType_Lbl: Label 'Sales Type';
        Shippinzone_Lbl: Label 'Shipping Zone';
        ItemNo_Lbl: Label 'Item Number';
        Description_Lbl: Label 'Description';
        Shipped_Lbl: Label 'Shipped';
        UnitPrice_Lbl: Label 'Unit Price';
        ExtPrice_Lbl: Label 'Ext. Price';
        Curr_Lbl: Label 'Currency';
        BaseUnitPrice_Lbl: Label 'Base Unit Price';
        BaseExtPrice_Lbl: Label 'Base Ext. Price';
        UnitCost_Lbl: Label 'Unit Cost';
        ExtCost_Lbl: Label 'Ext. Cost';
        Margin_Lbl: Label 'Margin';
        MarginPer_Lbl: Label 'Margin%';
        Cust_Lbl: Label 'Customer';
        UOM_Lbl: Label 'UOM';
        ShipToName_Lbl: Label 'Ship To Name';
        ShipToAddr_Lbl: Label 'Ship To Address1';
        ShipToAddr2_Lbl: Label 'Ship To Address2';
        ShipCity_Lbl: Label 'Ship To City';
        ShipState_Lbl: Label 'Ship To State';
        Zip_Lbl: Label 'Zip Code';
        Customer: Record Customer;
        InvDate: Date;
        OrderDate: Date;
        SalesType: Code[10];
        ShipToName: Text;
        ShipToAddr: Text;
        ShipToAddr2: Text;
        ShipToCity: Text;
        ShipToState: Text;
        ZIP: Text;
        Currency: Text;
        SalesPerson: Code[10];
        OnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        SalespersonCaption: Label 'Sales Person';
        PostingDateCaption: Label 'Posting Date';
        UnitcostVal: Decimal;
        ExtPriceVal: Decimal;
        BaseExtPriceVal: Decimal;
        ExtCostVal: Decimal;
        MarginVal: Decimal;
        MarginPerVal: Decimal;
        FixedAsset: Record "Fixed Asset";
        Resource: Record Resource;
        GLAccount: Record "G/L Account";
        UserSetup: Record "User Setup";
        SalespersonFilter: Code[20];
        Commission: Decimal;
        recSalesPrice: Record "Sales Price";
        i: Integer;
        AdminFee: Decimal;
        AdminFeePer: Integer;
        AdminCode: Code[20];
        SalesAmnt: Decimal;
        AdminCodeLbl: Label 'Admin Code';
        AdminFeePercLbl: Label 'Admin Fee %';
        AdminFeeRateLbl: Label 'Admin Fee $';
}

