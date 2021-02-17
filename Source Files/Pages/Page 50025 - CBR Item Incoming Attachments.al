page 50025 "Item Incoming Attachments"
{
    Caption = 'Attachments';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Incoming Document Attachment";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field(Name; Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IncomingDocument.CBRShowCard("Document No.");//CAN_SC_22/02/2018..>>
                    end;
                }
                field(Type; Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        IncomingDocument: Record "Incoming Document";
        DocumentNo: Code[20];


    procedure GetDocumentNo(ItemNo: Code[20])
    begin
        DocumentNo := ItemNo;
    end;
}

