codeunit 50002 CBRExtendCorrectPstdSalesInv
{
    trigger OnRun()
    begin

    end;

    procedure UpdateShipInformation(VAR SalesHeaderLoc: Record "Sales Header")
    var
        ShipToAddr: Record "Ship-to Address";
        UpdateDetails: Boolean;
    begin
        IF NOT ShipToAddr.GET(SalesHeaderLoc."Sell-to Customer No.", 'ST01') THEN
            UpdateDetails := TRUE
        ELSE
            UpdateDetails := FALSE;

        WITH SalesHeaderLoc DO BEGIN
            "Ship-to Code" := 'ST01';
            IF UpdateDetails THEN BEGIN
                "Ship-to Name" := ShipToAddr.Name;
                "Ship-to Name 2" := ShipToAddr."Name 2";
                "Ship-to Address" := ShipToAddr.Address;
                "Ship-to Address 2" := ShipToAddr."Address 2";
                "Ship-to City" := ShipToAddr.City;
                "Ship-to Post Code" := ShipToAddr."Post Code";
                "Ship-to County" := ShipToAddr.County;
                "Ship-to Contact" := ShipToAddr.Contact;
                "Shipment Method Code" := ShipToAddr."Shipment Method Code";
                "Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
                "Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
                "CBR Shipper AcctNo" := ShipToAddr."Telex Answer Back";//CBR_SS
                IF ShipToAddr."Tax Area Code" <> '' THEN
                    "Tax Area Code" := ShipToAddr."Tax Area Code";
                "Tax Liable" := ShipToAddr."Tax Liable";
            END;
            MODIFY;
        END;
    end;

    var
        myInt: Integer;
}