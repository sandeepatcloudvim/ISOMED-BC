tableextension 50008 CBRExtendShipToAddress extends "Ship-to Address"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBR GLN"; Text[20])
        {
            Caption = 'GLN';
            DataClassification = CustomerContent;
        }
        field(50001; "CBR Member ID"; Text[20])
        {
            Caption = 'Member ID';
            DataClassification = CustomerContent;
        }
        field(50002; "CBR License No."; Text[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
        }
        field(50003; "CBR Old Ship-To Code"; Code[10])
        {
            Caption = 'Old Ship-To Code';
            DataClassification = CustomerContent;
        }
        field(50004; "CBR Free Shipping"; Boolean)
        {
            Caption = 'Free Shipping';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //CAN-SS.1102-1++
                //IF "CBR Free Shipping" THEN
                //CBRCreateDShipFreightPrice
                //ELSE
                //CBRDeleteDShipFreightPrice
                //CAN-SS.1102-1--
            end;
        }
    }

    trigger OnBeforeDelete()
    begin
        //CBRDeleteDShipInfo;//CBR_SS
    end;

    //procedure CBRUpdateDShipInfo()

    // var
    //     DSHIPPackageOptions: Record "DSHIP Package Options";
    //     DSHIPCustomerOptions: Record "DSHIP Customer Options";
    //     FilterString: Text;
    //     Cust: Record Customer;
    // begin
    //     IF DeleteActivated THEN
    //         EXIT;
    //     FilterString := "Customer No." + '-' + Code;
    //     DSHIPPackageOptions.RESET;
    //     DSHIPPackageOptions.SETRANGE("License Plate No.", FilterString);
    //     IF DSHIPPackageOptions.FINDFIRST THEN BEGIN
    //         DSHIPPackageOptions."Bill Third Party Account No." := "Telex Answer Back";
    //         DSHIPPackageOptions."Entry Type" := DSHIPPackageOptions."Entry Type"::template;
    //         DSHIPPackageOptions."Created On" := TODAY;
    //         DSHIPPackageOptions."Created By" := USERID;
    //         DSHIPPackageOptions.MODIFY;
    //     END ELSE BEGIN
    //         DSHIPPackageOptions.INIT;
    //         DSHIPPackageOptions."License Plate No." := "Customer No." + '-' + Code;
    //         DSHIPPackageOptions."Bill Third Party Account No." := "Telex Answer Back";
    //         DSHIPPackageOptions."Entry Type" := DSHIPPackageOptions."Entry Type"::template;
    //         DSHIPPackageOptions."Created On" := TODAY;
    //         DSHIPPackageOptions."Created By" := USERID;
    //         IF DSHIPPackageOptions.INSERT THEN;
    //     END;
    //     Cust.GET("Customer No.");

    //     DSHIPCustomerOptions.RESET;
    //     DSHIPCustomerOptions.SETRANGE("Customer No.", "Customer No.");
    //     DSHIPCustomerOptions.SETRANGE("Ship-To Code", Code);
    //     IF DSHIPCustomerOptions.FINDFIRST THEN BEGIN
    //         DSHIPCustomerOptions."Package Options Template Code" := "Customer No." + '-' + Code;
    //         DSHIPCustomerOptions."Shipment Options Template Code" := 'THIRDPARTY';
    //         DSHIPCustomerOptions."Customer E-mail Source" := DSHIPCustomerOptions."Customer E-mail Source"::"Sell-To Customer No.";
    //         IF DSHIPCustomerOptions.MODIFY THEN;
    //     END ELSE BEGIN
    //         DSHIPCustomerOptions.INIT;
    //         DSHIPCustomerOptions."Customer No." := "Customer No.";
    //         DSHIPCustomerOptions."Ship-To Code" := Code;
    //         DSHIPCustomerOptions."Package Options Template Code" := "Customer No." + '-' + Code;
    //         IF "Shipping Agent Code" <> '' THEN
    //             DSHIPCustomerOptions."Shipping Agent Code" := "Shipping Agent Code"
    //         ELSE
    //             DSHIPCustomerOptions."Shipping Agent Code" := Cust."Shipping Agent Code";
    //         IF "Shipping Agent Service Code" <> '' THEN
    //             DSHIPCustomerOptions."Shipping Agent Service Code" := "Shipping Agent Service Code"
    //         ELSE
    //             DSHIPCustomerOptions."Shipping Agent Service Code" := Cust."Shipping Agent Service Code";

    //         DSHIPCustomerOptions."Shipment Options Template Code" := 'THIRDPARTY';
    //         DSHIPCustomerOptions."Customer E-mail Source" := DSHIPCustomerOptions."Customer E-mail Source"::"Sell-To Customer No.";
    //         IF DSHIPCustomerOptions.INSERT THEN;
    //     END;
    // end;

    // procedure CBRDeleteDShipInfo()
    // var
    //     DSHIPPackageOptions: Record "DSHIP Package Options";
    //     DSHIPCustomerOptions: Record "DSHIP Customer Options";
    //     FilterString: Text;
    //     Cust: Record Customer;
    // begin
    //     FilterString := "Customer No." + '-' + Code;
    //     DSHIPPackageOptions.RESET;
    //     DSHIPPackageOptions.SETRANGE("License Plate No.", FilterString);
    //     IF DSHIPPackageOptions.FINDSET THEN
    //         DSHIPPackageOptions.DELETEALL;

    //     DSHIPCustomerOptions.RESET;
    //     DSHIPCustomerOptions.SETRANGE("Customer No.", "Customer No.");
    //     DSHIPCustomerOptions.SETRANGE("Ship-To Code", Code);
    //     IF DSHIPCustomerOptions.FINDSET THEN
    //         DSHIPCustomerOptions.DELETEALL;
    //     DeleteActivated := TRUE;
    // end;

    // local procedure CBRCreateDShipFreightPrice()
    // var
    //     DSHIPFreightPrice: Record "DSHIP Freight Price";
    // begin
    //     DSHIPFreightPrice.INIT;
    //     DSHIPFreightPrice."Sales Type" := DSHIPFreightPrice."Sales Type"::Customer;
    //     DSHIPFreightPrice."Sales Code" := "Customer No.";
    //     DSHIPFreightPrice."Shipping Agent Code" := "Shipping Agent Code";
    //     DSHIPFreightPrice."Shipping Agent Service Code" := "Shipping Agent Service Code";
    //     DSHIPFreightPrice."Rate Handling" := DSHIPFreightPrice."Rate Handling"::"Don't Add Freight Charge";
    //     IF NOT DSHIPFreightPrice.INSERT THEN
    //         DSHIPFreightPrice.MODIFY;
    //     "Telex Answer Back" := '';
    // end;

    // local procedure CBRDeleteDShipFreightPrice()
    // var
    //     DSHIPFreightPrice: Record "DSHIP Freight Price";
    // begin
    //     DSHIPFreightPrice.RESET;
    //     DSHIPFreightPrice.SETRANGE("Sales Type", DSHIPFreightPrice."Sales Type"::Customer);
    //     DSHIPFreightPrice.SETRANGE("Sales Code", "Customer No.");
    //     IF DSHIPFreightPrice.FINDFIRST THEN
    //         DSHIPFreightPrice.DELETE;

    // end;

    var
        DeleteActivated: Boolean;
}