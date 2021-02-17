tableextension 50004 CBRExtendPurchaseLine extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBR Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
            Description = 'CBR_SS';
        }
        field(50001; "CBR Last Shipment Date"; Date)
        {
            Caption = 'Last Shipment Date';
            DataClassification = CustomerContent;
            Description = 'CBR_SS';
        }
    }

    var
        myInt: Integer;
}