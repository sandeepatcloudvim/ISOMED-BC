report 50013 "Manufacturer Sales Report"
{
    // CBR_SS : 23/03/2018 : New report created
    DefaultLayout = RDLC;
    RDLCLayout = './ManufacturerSalesReport.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Comp_Name; Compinfo.Name)
                {
                }
                column(Comp_Add; Compinfo.Address)
                {
                }
                column(Comp_Add1; Compinfo."Address 2")
                {
                }
                column(Comp_City; Compinfo.City)
                {
                }
                column(Comp_Phone; Compinfo."Phone No.")
                {
                }
                column(Comp_Pic; Compinfo.Picture)
                {
                }
                column(Date; Today)
                {
                }
                column(Cust_No; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(Location_Code; "Sales Invoice Line"."Location Code")
                {
                }
                column(Cust_Name; RecCust.Name)
                {
                }
                column(Cust_Add; RecCust.Address)
                {
                }
                column(Cust_City; RecCust.City)
                {
                }
                column(Cust_State; RecCust.County)
                {
                }
                column(Cust_Zip; RecCust."Post Code")
                {
                }
                column(Item_No; "Sales Invoice Line"."No.")
                {
                }
                column(Item_Desc; RecItem.Description)
                {
                }
                column(Item_UnitCost; RecItem."Unit Cost")
                {
                }
                column(UOM; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Qty_Per_UOM; "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(Purchase_Qty; PurchLine.Quantity)
                {
                }
                column(PO_No; "Sales Invoice Header"."External Document No.")
                {
                }
                column(PO_Date; "Sales Invoice Header"."Order Date")
                {
                }
                column(Inv_No; "Sales Invoice Header"."No.")
                {
                }
                column(Inv_Date; "Sales Invoice Header"."Posting Date")
                {
                }
                column(Shipto_Name_CBR; "Sales Invoice Header"."Ship-to Name")
                {
                }
                column(Shipto_Address_CBR; "Sales Invoice Header"."Ship-to Address")
                {
                }
                column(Shipto_Address2_CBR; "Sales Invoice Header"."Ship-to Address 2")
                {
                }
                column(Shipto_City_CBR; "Sales Invoice Header"."Ship-to City")
                {
                }
                column(Shipto_State_CBR; "Sales Invoice Header"."Ship-to County")
                {
                }
                column(Shipto_ZIP_CBR; "Sales Invoice Header"."Ship-to Post Code")
                {
                }
                column(Unit_Price; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Inv_Qty; "Sales Invoice Line".Quantity)
                {
                }
                column(Inv_Qty_CasePack; "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(Line_Amount; "Sales Invoice Line"."Line Amount")
                {
                }
                column(AdminFee_Per; AdminFeePer)
                {
                }
                column(AdminFee; AdminFee)
                {
                }
                column(Ship_to_Code; AddVar[1])
                {
                }
                column(Ship_to_Name; AddVar[2])
                {
                }
                column(Ship_to_Address; AddVar[3])
                {
                }
                column(Ship_to_Address1; AddVar[4])
                {
                }
                column(Ship_to_City; AddVar[5])
                {
                }
                column(Ship_to_State; AddVar[6])
                {
                }
                column(Ship_to_Zip_Code; AddVar[7])
                {
                }
                column(ExtCostVal; ExtCostVal)
                {
                }
                column(UnitcostVal; UnitcostVal)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    if RecCust.Get("Sales Invoice Line"."Sell-to Customer No.") then;
                    if RecItem.Get("Sales Invoice Line"."No.") then;

                    if RecItem."Manufacturer Code" <> ManufacturerCode then
                        CurrReport.Skip;

                    /*
                    PurchHead.RESET;
                    PurchHead.SETRANGE("No.","Sales Invoice Header"."External Document No.");
                    IF PurchHead.FINDFIRST THEN
                    BEGIN
                      PurchLine.RESET;
                      PurchLine.SETRANGE("Document No.",PurchHead."No.");
                      PurchLine.SETRANGE("No.","Sales Invoice Line"."No.");
                      IF PurchLine.FINDFIRST THEN;
                    END;
                    */

                    AdminFeePer := 5;
                    AdminFee := ("Sales Invoice Line"."Line Amount" * 5) / 100;



                    if "Sales Invoice Header"."Ship-to Code" <> '' then begin

                        // Subhash, this code does not make any sense to me. The Ship-to Address is on the Sales Invoice Header, nowhere else...


                        //  RecShipTo.GET("Sales Invoice Header"."Sell-to Customer No.","Sales Invoice Header"."Ship-to Code");
                        //  AddVar[1] := "Sales Invoice Header"."Sell-to Customer No.";
                        //  AddVar[2] := RecShipTo.Name;
                        //  AddVar[3] := RecShipTo.Address;
                        //  AddVar[4] := RecShipTo."Address 2";
                        //  AddVar[5] := RecShipTo.City;
                        //  AddVar[6] := RecShipTo.County;
                        //  AddVar[7] := RecShipTo."Post Code";
                        //CBR_SS 10/02/18++
                        AddVar[1] := "Sales Invoice Header"."Sell-to Customer No.";
                        AddVar[2] := "Sales Invoice Header"."Ship-to Name";
                        AddVar[3] := "Sales Invoice Header"."Ship-to Address";
                        AddVar[4] := "Sales Invoice Header"."Ship-to Address 2";
                        AddVar[5] := "Sales Invoice Header"."Ship-to City";
                        AddVar[6] := "Sales Invoice Header"."Ship-to County";
                        AddVar[7] := "Sales Invoice Header"."Ship-to Post Code";
                    end else begin
                        RecCust.Get("Sales Invoice Header"."Sell-to Customer No.");
                        AddVar[1] := "Sales Invoice Header"."Sell-to Customer No.";
                        AddVar[2] := RecCust.Name;
                        AddVar[3] := RecCust.Address;
                        AddVar[4] := RecCust."Address 2";
                        AddVar[5] := RecCust.City;
                        AddVar[6] := RecCust.County;
                        AddVar[7] := RecCust."Post Code";
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    AdminFee := 0;
                    SalesAmt := 0;
                    if FromDate = 0D then
                        FromDate := 20010101D;

                    if ToDate = 0D then
                        ToDate := Today;

                    SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Intalera Sales")
                {
                    Caption = 'Intalera Sales';
                    field("Date Filter"; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                    }
                    field("Manufacturer Code"; ManufacturerCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Manufacturer Code';
                        TableRelation = Manufacturer;
                    }
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
        Compinfo.Get;
        Compinfo.CalcFields(Picture);
        if ManufacturerCode = '' then
            Error('Please Select the Manufacturer Code');
    end;

    var
        Compinfo: Record "Company Information";
        RecCust: Record Customer;
        RecItem: Record Item;
        PurchHead: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        AdminFeePer: Integer;
        AdminFee: Decimal;
        SalesAmt: Decimal;
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        QtyShipped: Decimal;
        ShipHead: Record "Sales Shipment Header";
        ShipLine: Record "Sales Shipment Line";
        DateFilter: Text;
        ManufacturerCode: Code[10];
        FromDate: Date;
        ToDate: Date;
        RecShipTo: Record "Ship-to Address";
        AddVar: array[10] of Text;
        UnitcostVal: Decimal;
        Item: Record Item;
        Resource: Record Resource;
        ExtCostVal: Decimal;
}

