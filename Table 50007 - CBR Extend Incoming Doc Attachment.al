tableextension 50007 ExtendIncomingDocAttachIsomed extends "Incoming Document Attachment"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBR Lot No."; Code[20])
        {
            Caption = 'Lot No.';
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
        field(50003; "CBR Serial No"; Code[20])
        {
            Caption = 'Serial No';
            DataClassification = CustomerContent;
            Description = 'CBR_SS 26042018';
        }
    }

    procedure CBRNewAttachmentFromILE(ILE: Record "Item Ledger Entry"; LotNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20])
    var
        IncomingDocAttachment: Record "Incoming Document Attachment";
        IncomingDoc: Record "Incoming Document";
    begin
        //CBR_SS..>>
        IF ILE."Entry No." <> 0 THEN BEGIN
            SETRANGE("Document Table No. Filter", DATABASE::"Item Ledger Entry");
            SETRANGE("Document No. Filter", FORMAT(ILE."Entry No."));
        END ELSE BEGIN
            // SETRANGE("CBR Serial No", SerialNo);
            SETRANGE("CBR Lot No.", LotNo);
            SETRANGE("CBR Item No.", ItemNo);
            SETRANGE("CBR Variant Code", "CBR Variant Code");
        END;
        NewAttachment;
        IF IncomingDoc.GET("Incoming Document Entry No.") THEN BEGIN
            //IncomingDoc."CBR Serial No." := SerialNo;
            IncomingDoc."CBR Lot No." := LotNo;
            IncomingDoc."CBR Item No." := ItemNo;
            IncomingDoc."CBR Variant Code" := VariantCode;
            IncomingDoc.MODIFY;
        END;
        IF IncomingDocAttachment.GET("Incoming Document Entry No.", "Line No.") THEN BEGIN
            // IncomingDocAttachment."CBR Serial No" := SerialNo;
            IncomingDocAttachment."CBR Lot No." := LotNo;
            IncomingDocAttachment."CBR Item No." := ItemNo;
            IncomingDocAttachment."CBR Variant Code" := VariantCode;
            IncomingDocAttachment.MODIFY;
        END;
        //CBR_SS..<<
    end;

    procedure CBRNewAttachmentFromWareHouseEntry(WareouseEntry: Record "Warehouse Entry"; LotNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20])
    var
        IncomingDocAttachment: Record "Incoming Document Attachment";
        IncomingDoc: Record "Incoming Document";
    begin
        //CBR_SS..>>
        IF WareouseEntry.FINDFIRST THEN BEGIN
            SETRANGE("Document Table No. Filter", DATABASE::"Warehouse Entry");
            SETRANGE("Document No. Filter", FORMAT(WareouseEntry."Entry No."));
        END ELSE BEGIN
            //SETRANGE("CBR Serial No", SerialNo);
            SETRANGE("CBR Lot No.", LotNo);
            SETRANGE("CBR Item No.", ItemNo);
            SETRANGE("CBR Variant Code", "CBR Variant Code");

        END;
        NewAttachment;

        IF IncomingDoc.GET("Incoming Document Entry No.") THEN BEGIN
            IncomingDoc."CBR Serial No." := WareouseEntry."Serial No.";
            IncomingDoc."CBR Lot No." := WareouseEntry."Lot No.";
            IncomingDoc."CBR Item No." := WareouseEntry."Item No.";
            IncomingDoc."CBR Variant Code" := WareouseEntry."Variant Code";
            IncomingDoc.MODIFY;
        END;
        IF IncomingDocAttachment.GET("Incoming Document Entry No.", "Line No.") THEN BEGIN
            IncomingDocAttachment."CBR Serial No" := WareouseEntry."Serial No.";
            IncomingDocAttachment."CBR Lot No." := WareouseEntry."Lot No.";
            IncomingDocAttachment."CBR Item No." := WareouseEntry."Item No.";
            IncomingDocAttachment."CBR Variant Code" := WareouseEntry."Variant Code";
            IncomingDocAttachment.MODIFY;
        END;
        //CBR_SS..<<

    end;

    procedure CBRNewAttachmentFrmItemTrackingLines(SerialNo: Code[20]; LotNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20])
    var
        IncomingDocAttachment: Record "Incoming Document Attachment";
        IncomingDoc: Record "Incoming Document";
    begin
        //CBR_SS..>>

        SETRANGE("CBR Serial No", SerialNo);
        SETRANGE("CBR Lot No.", LotNo);
        SETRANGE("CBR Item No.", ItemNo);
        SETRANGE("CBR Variant Code", "CBR Variant Code");

        NewAttachment;

        IF IncomingDoc.GET("Incoming Document Entry No.") THEN BEGIN
            IncomingDoc."CBR Serial No." := SerialNo;
            IncomingDoc."CBR Lot No." := LotNo;
            IncomingDoc."CBR Item No." := ItemNo;
            IncomingDoc."CBR Variant Code" := VariantCode;
            IncomingDoc.MODIFY;
        END;
        IF IncomingDocAttachment.GET("Incoming Document Entry No.", "Line No.") THEN BEGIN
            IncomingDocAttachment."CBR Serial No" := SerialNo;
            IncomingDocAttachment."CBR Lot No." := LotNo;
            IncomingDocAttachment."CBR Item No." := ItemNo;
            IncomingDocAttachment."CBR Variant Code" := VariantCode;
            IncomingDocAttachment.MODIFY;
        END;
        //CBR_SS..<<
    end;

    var
        myInt: Integer;
}