tableextension 50002 CBRExtendSalesHeader extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50003; "CBR Shipper AcctNo"; Code[30])
        {
            Caption = 'Shipper AcctNo';
            DataClassification = CustomerContent;
        }
        field(50000; "CBR Created By UserID"; Code[50])
        {
            Caption = 'Created By UserID';
            DataClassification = CustomerContent;
        }
        field(50001; "CBR Created By User Name"; Text[50])
        {
            Caption = 'Created By User Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "CBR Creation Time"; Time)
        {
            Caption = 'Creation Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "CBR Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50006; "CBR GLN"; Text[20])
        {
            Caption = 'GLN';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50007; "CBR Member ID"; Text[20])
        {
            Caption = 'Member ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50008; "CBR License No."; Text[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
        }
        field(50009; "CBR Closed"; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
            Description = 'CBR_SS';
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                //CAN_AG 02/25/20 >>

                Rec.CBRGetInfoFromShip(Rec."Sell-to Customer No.");
                //CAN_AG 02/25/20 <<
            end;
        }
    }

    trigger OnInsert()
    begin
        //CBR_SS++
        "CBR Created By UserID" := USERID;
        "CBR Created By User Name" := CBRGetUserName;
        "CBR Creation Time" := TIME;
        "CBR Creation Date" := TODAY;
        //CBR_SS--
    end;

    trigger OnBeforeDelete()
    begin
        //ArchiveManagement.ArchSalesDocumentNoConfirm(Rec); //CBR_SS_0309/2018..>>
    end;

    local procedure CBRGetUserName(): Text
    var
        UserRec: Record User;
    begin
        //CBR_SS++
        UserRec.RESET;
        UserRec.SETRANGE("User Name", USERID);
        IF UserRec.FINDFIRST THEN
            EXIT(UserRec."Full Name")
        //CBR_SS--
    end;

    procedure CBRGetInfoFromShip(CustomerNo: Code[20])
    begin
        //CBR_SS 10/11/2018++>>
        recShipToAdd.RESET;
        recShipToAdd.SETRANGE("Customer No.", CustomerNo);
        recShipToAdd.SETRANGE(Name, "Sell-to Customer Name");
        IF recShipToAdd.FINDFIRST THEN BEGIN
            "CBR Member ID" := recShipToAdd."CBR Member ID";
            "CBR GLN" := recShipToAdd.GLN;
            "CBR License No." := recShipToAdd."CBR License No.";
        END;
        //CBR_SS 10/11/2018--<<
    end;

    procedure CBRDuplicateExtNoShipment(): Boolean
    begin
        //CBR_SS 02/08/2019++>>
        recSalesShipmentHeader.RESET;
        recSalesShipmentHeader.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        recSalesShipmentHeader.SETRANGE("External Document No.", "External Document No.");
        IF recSalesShipmentHeader.FINDFIRST THEN BEGIN
            //ERROR(Text073,recSalesShipmentHeader."Order No.");//CBR_SS 
            MESSAGE(Text073, recSalesShipmentHeader."Order No.");
            EXIT(TRUE);
        END;
        //CBR_SS 02/08/2019--<<
    end;

    procedure CBRDuplicateExtNoInvoice()
    begin
        //CBR_SS 02/08/2019++>>
        recSalesInvoiceHeader.RESET;
        recSalesInvoiceHeader.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
        recSalesInvoiceHeader.SETRANGE("External Document No.", "External Document No.");
        IF recSalesInvoiceHeader.FINDFIRST THEN
            //ERROR(Text073,recSalesInvoiceHeader."Order No.");//CBR_SS 
            MESSAGE(Text073, recSalesInvoiceHeader."Order No.");
        //CBR_SS 02/08/2019--<<
    end;

    var
        ArchiveManagement: Codeunit ArchiveManagement;
        recShipToAdd: Record "Ship-to Address";
        recSalesShipmentHeader: Record "Sales Shipment Header";
        recSalesInvoiceHeader: Record "Sales Invoice Header";
        Text073: label 'This Customer PO Number has been used on Sales Order %1 already. Please confirm that this is not a duplication.';
}