report 50015 "Intalere Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IntalereSales.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Posting Date";
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE("Customer Price Group" = FILTER('INTALERE'), Quantity = FILTER(<> 0));
                    column(Cust_No; Customer."No.")
                    {
                    }
                    column(Sell_To_Cust; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(Ship_To_Code; "Sales Invoice Header"."Ship-to Code")
                    {
                    }
                    column(Ship_To_Name; "Sales Invoice Header"."Ship-to Name")
                    {
                    }
                    column(Ship_To_Address; "Sales Invoice Header"."Ship-to Address")
                    {
                    }
                    column(Ship_To_Address2; "Sales Invoice Header"."Ship-to Address 2")
                    {
                    }
                    column(Ship_To_City; "Sales Invoice Header"."Ship-to City")
                    {
                    }
                    column(Ship_To_State; "Sales Invoice Header"."Ship-to County")
                    {
                    }
                    column(Ship_To_ZIP; "Sales Invoice Header"."Ship-to Post Code")
                    {
                    }
                    column(Inv_No; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Inv_Date; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(Qty_Invoiced; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(Unit_Price; "Sales Invoice Line"."Unit Price")
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
                    column(Item_No; RecItem."No.")
                    {
                    }
                    column(Item_Desc; RecItem.Description)
                    {
                    }
                    column(Item_UnitCost; RecItem."Unit Cost")
                    {
                    }
                    column(Purchase_Qty; PurchLine.Quantity)
                    {
                    }
                    column(SalesAmt; SalesAmt)
                    {
                    }
                    column(PO_No; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(PO_Date; "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(UOM_Code; "Sales Invoice Line"."Unit of Measure")
                    {
                    }
                    column(Qty_Per_UOM; "Sales Invoice Line"."Qty. per Unit of Measure")
                    {
                    }
                    column(Dist_Assigned_Prod_No; "Sales Invoice Line"."No.")
                    {
                    }
                    column(Supplier_Product_Description; "Sales Invoice Line".Description)
                    {
                    }
                    column(Cust_Proce_Grp; "Sales Invoice Header"."Customer Price Group")
                    {
                    }
                    column(Comp_Name; CompInfo.Name)
                    {
                    }
                    column(Comp_Add; CompInfo.Address)
                    {
                    }
                    column(Comp_City; CompInfo.City)
                    {
                    }
                    column(Comp_Phone; CompInfo."Phone No.")
                    {
                    }
                    column(pic; CompInfo.Picture)
                    {
                    }
                    column(Date; Today)
                    {
                    }
                    column(i; i)
                    {
                    }
                    column(AdminFee; AdminFee)
                    {
                    }
                    column(AdminFeePer; AdminFeePer)
                    {
                    }
                    column(Ship_To_GLN; "Sales Invoice Header"."CBR GLN")
                    {
                    }
                    column(Ship_To_LIC; "Sales Invoice Header"."CBR License No.")
                    {
                    }
                    column(Ship_To_MemberID; "Sales Invoice Header"."CBR Member ID")
                    {
                    }
                    column(CustomerPriceGroup; "Sales Invoice Line"."Customer Price Group")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        if RecCust.Get("Sales Invoice Line"."Sell-to Customer No.") then;
                        if RecItem.Get("Sales Invoice Line"."No.") then;

                        //CBR_SS++ Check if there is item in the customer price group++
                        VizientSalesPrice.Reset;
                        VizientSalesPrice.SetRange("Item No.", "Sales Invoice Line"."No.");
                        VizientSalesPrice.SetRange("Sales Type", VizientSalesPrice."Sales Type"::"Customer Price Group");
                        VizientSalesPrice.SetRange("Sales Code", "Sales Invoice Line"."Customer Price Group");
                        if not VizientSalesPrice.FindFirst then
                            CurrReport.Skip;
                        //CBR_SS--
                        SalesAmt := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                        AdminFeePer := 5;
                        AdminFee := (SalesAmt * AdminFeePer) / 100;
                        i += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        i := 0;
                        Clear(AdminFeePer);
                        Clear(AdminFee);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //CBR_SS++ 11/10/2018 >>
                    // //CBR_SS++
                    // recShipAddress.RESET;
                    // recShipAddress.SETRANGE("Customer No.","Sell-to Customer No.");
                    // recShipAddress.SETRANGE(Code,"Ship-to Code");
                    // IF recShipAddress.FINDFIRST THEN BEGIN
                    //  ShipToGLN := recShipAddress.GLN;
                    //  ShipToLIC := recShipAddress."License No.";
                    //  ShipToMemberID := recShipAddress."Member ID";
                    // END;
                    // //CBR_SS--
                    //CBR_SS++ 11/10/2018 <<
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CustLedEntry: Record "Cust. Ledger Entry";
        SalesAmt: Decimal;
        CompInfo: Record "Company Information";
        i: Integer;
        VizientSalesPrice: Record "Sales Price";
        AdminFee: Decimal;
        AdminFeePer: Integer;
        ShipToGLN: Text[20];
        ShipToLIC: Text[20];
        ShipToMemberID: Text[20];
        recShipAddress: Record "Ship-to Address";
        RecCust: Record Customer;
        RecItem: Record Item;
        PurchLine: Record "Purchase Line";
}

