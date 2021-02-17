tableextension 50013 CBRExtendSalesCrMemoHeader extends "Sales Cr.Memo Header"
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
    }

    var
        myInt: Integer;
}