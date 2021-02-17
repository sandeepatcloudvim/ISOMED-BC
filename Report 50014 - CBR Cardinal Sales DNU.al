report 50014 "Cardinal Sales DNU"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CardinalSalesDNU.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Comp_Name; CompInfo.Name)
                {
                }
                column(Comp_Add; CompInfo.Address)
                {
                }
                column(Comp_Add1; CompInfo."Address 2")
                {
                }
                column(Comp_City; CompInfo.City)
                {
                }
                column(Comp_Phone; CompInfo."Phone No.")
                {
                }
                column(Comp_Pic; CompInfo.Picture)
                {
                }
                column(Date; Today)
                {
                }
                column(Branch; "Sales Invoice Header"."Location Code")
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
                column(Item_No; "Sales Invoice Line"."No.")
                {
                }
                column(Item_Desc; RecItem.Description)
                {
                }
                column(Qty; "Sales Invoice Line".Quantity)
                {
                }
                column(UOM; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Unit_Price; "Sales Invoice Line"."Unit Price")
                {
                }
                column(PurchPrice; PurchPrice)
                {
                }
                column(PurInvDate; PurInvDate)
                {
                }
                column(Invoice_No; "Sales Invoice Header"."No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if RecItem.Get("Sales Invoice Line"."No.") then;

                    /*
                    RecPurcInvLine.RESET;
                    RecPurcInvLine.SETRANGE("Document No.","Sales Invoice Header"."External Document No.");
                    RecPurcInvLine.SETRANGE("No.","Sales Invoice Line"."No.");
                    IF RecPurcInvLine.FINDFIRST THEN
                    BEGIN
                      PurchPrice := RecPurcInvLine."Line Amount";
                      PurInvDate := RecPurcInvLine."Posting Date";
                    END;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Sales Invoice Header"."Ship-to Code" <> '' then begin
                    //  RecShipTo.GET("Sales Invoice Header"."Sell-to Customer No.","Sales Invoice Header"."Ship-to Code");
                    //  AddVar[1] := "Sales Invoice Header"."Sell-to Customer No.";
                    //  AddVar[2] := RecShipTo.Name;
                    //  AddVar[3] := RecShipTo.Address;
                    //  AddVar[4] := RecShipTo."Address 2";
                    //  AddVar[5] := RecShipTo.City;
                    //  AddVar[6] := RecShipTo.County;
                    //  AddVar[7] := RecShipTo."Post Code";
                    //CBR_SS 10/03/18++
                    AddVar[1] := "Sales Invoice Header"."Sell-to Customer No.";
                    AddVar[2] := "Sales Invoice Header"."Ship-to Name";
                    AddVar[3] := "Sales Invoice Header"."Ship-to Address";
                    AddVar[4] := "Sales Invoice Header"."Ship-to Address 2";
                    AddVar[5] := "Sales Invoice Header"."Ship-to City";
                    AddVar[6] := "Sales Invoice Header"."Ship-to County";
                    AddVar[7] := "Sales Invoice Header"."Ship-to Post Code";
                    //CBR_SS 10/03/18--
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
                Clear(AddVar);
            end;
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
        CompInfo: Record "Company Information";
        RecCust: Record Customer;
        RecItem: Record Item;
        PurchLine: Record "Purchase Line";
        RecPurcInvLine: Record "Purch. Inv. Line";
        PurchPrice: Decimal;
        PurInvDate: Date;
        RecShipTo: Record "Ship-to Address";
        AddVar: array[10] of Text;
}

