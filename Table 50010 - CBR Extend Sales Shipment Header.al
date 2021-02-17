tableextension 50010 CBRExtendSalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "CBR Created By UserID"; Code[50])
        {
            Caption = 'Created By UserID';
            DataClassification = CustomerContent;

        }
        field(50001; "CBR Created By User Name"; Text[50])
        {
            Caption = 'Created By User Name';
            DataClassification = CustomerContent;

        }
        field(50002; "CBR Creation Time"; Time)
        {
            Caption = 'Creation Time';
            DataClassification = CustomerContent;

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
            Editable = false;
        }
    }

    var
        myInt: Integer;
}