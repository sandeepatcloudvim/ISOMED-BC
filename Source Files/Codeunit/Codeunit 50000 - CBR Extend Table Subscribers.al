codeunit 50000 CBRTableSubscribers
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', true, true)]
    procedure SelltoCustNoSalesHeader(VAR Rec: Record "Sales Header"; VAR xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        cust: Record Customer;
    begin
        //CBR_SS_08032017..>>
        if cust.Get(Rec."Sell-to Customer No.") then
            IF Cust.CBRDefaultPONo <> '' THEN
                Rec."External Document No." := Cust.CBRDefaultPONo;
        //CBR_SS_08032017..<<
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Code', true, true)]
    procedure ShipToCodeOnValidateSalesHeader(VAR Rec: Record "Sales Header"; VAR xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        ShipToAddr: Record "Ship-to Address";
    begin
        if ShipToAddr.GET(Rec."Sell-to Customer No.", Rec."Ship-to Code") then
            rec."CBR Shipper AcctNo" := ShipToAddr."Telex Answer Back";//CBR_SS
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Header", 'OnAfterValidateEvent', 'External Document No.', true, true)]
    procedure ExternalDocNoOnValidateSalesHeader(VAR Rec: Record "Sales Header"; VAR xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        //CBR_SS>>
        IF NOT Rec.CBRDuplicateExtNoShipment() THEN //CBR_SS 
            Rec.CBRDuplicateExtNoInvoice();
        //CBR_SS<<
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Line", 'OnAfterAssignItemValues', '', true, true)]
    procedure NoOnValidateSalesLine(VAR SalesLine: Record "Sales Line"; Item: Record Item)
    var
        Updated: Boolean;
    begin
        //CBR_SS++
        Updated := TRUE;
        SalesLine.CBRUpdateReplnCost(SalesLine);
        //CBR_SS--
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Line", 'OnAfterValidateEvent', 'No.', true, true)]
    procedure NoFieldOnValidateSalesLine(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        Updated: Boolean;
    begin
        Updated := FALSE;//CBR_SS
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Line", 'OnAfterValidateEvent', 'Unit of Measure Code', true, true)]
    procedure UnitofMeasureCodeOnValidateSalesLine(VAR Rec: Record "Sales Line"; VAR xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        //CBR_SS
        Rec.CBRUpdateUOMReplnCost(Rec);
        //CBR_SS
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Tax Area", 'OnAfterValidateEvent', 'Description', false, false)]
    procedure DescriptionOnValidate(VAR Rec: Record "Tax Area"; VAR xRec: Record "Tax Area"; CurrFieldNo: Integer)
    begin
        //CBR_SS 042419 >>
        IF STRLEN(rec.Description) > 30 THEN
            ERROR('Description Length should be less than 30 Character');
        //CBR_SS 042419 <<
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::Contact, 'OnAfterValidateEvent', 'Type', false, false)]
    procedure TypeOnAfterValidate(VAR Rec: Record Contact; VAR xRec: Record Contact; CurrFieldNo: Integer)
    var
        ContactBusRelation: Record "Contact Business Relation";
    begin
        //CBR_SS_TEST
        IF Rec.Type = Rec.Type::Person THEN BEGIN
            ContactBusRelation.RESET;
            ContactBusRelation.SETRANGE("Contact No.", Rec."Company No.");
            IF ContactBusRelation.FINDFIRST THEN BEGIN
                ContactBusRelation.CALCFIELDS("Business Relation Description");
                Rec."CBR Lead Type" := ContactBusRelation."Business Relation Description";
            END ELSE
                Rec."CBR Lead Type" := 'Lead';
        END
        ELSE
            Rec."CBR Lead Type" := '';
        //CBR_SS_TEST
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::Contact, 'OnAfterValidateEvent', 'Company No.', false, false)]
    procedure CompanyNoOnAfterValidateEvent(VAR Rec: Record Contact; VAR xRec: Record Contact; CurrFieldNo: Integer)
    var
        ContactBusRelation: Record "Contact Business Relation";
    begin
        //CBR_SS_TEST
        ContactBusRelation.RESET;
        ContactBusRelation.SETRANGE("Contact No.", Rec."Company No.");
        IF ContactBusRelation.FINDFIRST THEN BEGIN
            ContactBusRelation.CALCFIELDS("Business Relation Description");
            Rec."CBR Lead Type" := ContactBusRelation."Business Relation Description";
        END ELSE
            Rec."CBR Lead Type" := 'Lead';
        //CBR_SS_TEST
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::Contact, 'OnAfterValidateEvent', 'Company Name', false, false)]
    procedure CompanyNameOnAfterValidateEvent(VAR Rec: Record Contact; VAR xRec: Record Contact; CurrFieldNo: Integer)
    var
        ContactBusRelation: Record "Contact Business Relation";
    begin
        //CBR_SS_TEST
        ContactBusRelation.RESET;
        ContactBusRelation.SETRANGE("Contact No.", Rec."Company No.");
        IF ContactBusRelation.FINDFIRST THEN BEGIN
            ContactBusRelation.CALCFIELDS("Business Relation Description");
            Rec."CBR Lead Type" := ContactBusRelation."Business Relation Description";
        END ELSE
            Rec."CBR Lead Type" := 'Lead';
        //CBR_SS_TEST

    end;

    [EventSubscriber(ObjectType::Table, DATABASE::Contact, 'OnBeforeCustomerInsert', '', true, true)]
    procedure CreateCustomerOnBeforeCustomerInsert(VAR Cust: Record Customer; CustomerTemplate: Code[10]; VAR Contact: Record Contact)
    begin
        Cust.CBRSetNextCustNo(Contact."Company Name");  //CBR_SS_08052018
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAssistEditTrackingNoOnBeforeSetSources', '', true, true)]
    procedure FilterBinContentValue(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempGlobalEntrySummary: Record "Entry Summary" temporary; var MaxQuantity: Decimal)
    begin
        TempGlobalEntrySummary.SetFilter("Bin Content", '>%1', 0);
    end;
}