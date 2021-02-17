page 50018 "Item HTM Script"
{
    AutoSplitKey = true;
    Caption = 'Item HTM Script';
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "CBR Item Based HTML Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HTML Line Code"; "HTML Line Code")
                {
                    Caption = 'HTML Line Code';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //StyleExpressionTxt := GetStyleTxt;
    end;

    var
        MainRecordRef: RecordRef;
        StyleExpressionTxt: Text;


    procedure LoadDataFromRecord(MainRecordVariant: Variant)
    var
        IncomingDocument: Record "Incoming Document";
        DataTypeManagement: Codeunit "Data Type Management";
    begin
        /*
        IF NOT DataTypeManagement.GetRecordRef(MainRecordVariant,MainRecordRef) THEN
          EXIT;
        
        DELETEALL;
        
        IF NOT MainRecordRef.GET(MainRecordRef.RECORDID) THEN
          EXIT;
        
        IF GetIncomingDocumentRecord(MainRecordVariant,IncomingDocument) THEN
          InsertFromIncomingDocument(IncomingDocument,Rec);
        CurrPage.UPDATE(FALSE);
        */

    end;


    procedure LoadDataFromIncomingDocument(IncomingDocument: Record "Incoming Document")
    begin
        /*
        DELETEALL;
        InsertFromIncomingDocument(IncomingDocument,Rec);
        CurrPage.UPDATE(FALSE);
        */

    end;


    procedure GetIncomingDocumentRecord(MainRecordVariant: Variant; var IncomingDocument: Record "Incoming Document"): Boolean
    var
        DataTypeManagement: Codeunit "Data Type Management";
    begin
        /*
        IF NOT DataTypeManagement.GetRecordRef(MainRecordVariant,MainRecordRef) THEN
          EXIT(FALSE);
        
        CASE MainRecordRef.NUMBER OF
          DATABASE::"Incoming Document":
            BEGIN
              IncomingDocument.COPY(MainRecordVariant);
              EXIT(TRUE);
            END;
          ELSE BEGIN
            IF IncomingDocument.FindFromIncomingDocumentEntryNo(MainRecordRef,IncomingDocument) THEN
              EXIT(TRUE);
            IF IncomingDocument.FindByDocumentNoAndPostingDate(MainRecordRef,IncomingDocument) THEN
              EXIT(TRUE);
            EXIT(FALSE);
          END;
        END;
        */

    end;
}

