tableextension 50006 CBRExtendIncomingDocument extends "Incoming Document"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBR Lot No."; Code[20])
        {
            Caption = 'Lot No';
            DataClassification = CustomerContent;
            Description = 'CBR_SS 26042018';
        }
        field(50001; "CBR Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            Description = 'CBR_SS 26042018';
        }
        field(50002; "CBR Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
            Description = 'CBR_SS 26042018';
        }
        field(50003; "CBR Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
            Description = 'CBR_SS 26042018';
        }
    }

    procedure CBRShowCard_ILEAndWarehouseentry(SerialNo: Code[20]; LotNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20])
    begin
        //CBR_SS..>>
        RESET;
        //SETRANGE("CBR Serial No.", SerialNo);
        SETRANGE("CBR Lot No.", LotNo);
        SETRANGE("CBR Item No.", ItemNo);
        SETRANGE("CBR Variant Code", VariantCode);
        IF NOT FINDFIRST THEN
            EXIT;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Document", Rec);
        //CBR_SS..>>
    end;

    procedure CBRShowCard(DocumentNo: Code[20])
    begin
        RESET;
        SETRANGE("Document No.", DocumentNo);
        IF NOT FINDFIRST THEN
            EXIT;
        SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Document", Rec);
    end;

    var
        myInt: Integer;
}