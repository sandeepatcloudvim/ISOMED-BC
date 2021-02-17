pageextension 50034 CBRExtendSalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field("CBR Repl. Cost"; "CBR Repl. Cost")
            {
                Caption = 'Repl. Cost';
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            ApplicationArea = All;
            trigger OnAfterValidate()
            begin
                FreeShippingValidation; //CBR_SS>><<
            end;
        }

    }

    PROCEDURE FreeShippingValidation();
    BEGIN
        //CBR_SS>>
        IF SalesHeader.GET("Document Type", "Document No.") THEN;
        IF ShiptoAddress.GET(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code") THEN BEGIN
            IF ((ShiptoAddress."CBR Free Shipping" = TRUE) AND (COPYSTR(Rec."No.", 1, 2) = 'ZZ')) THEN
                ERROR(Text002);
        END;
        //CBR_SS<<
    END;


    var
        myInt: Integer;
        SalesHeader: Record "Sales Header";
        ShiptoAddress: Record "Ship-to Address";
        Text002: Label 'This customer has free shipping. Please update your freight charges accordingly.';



}