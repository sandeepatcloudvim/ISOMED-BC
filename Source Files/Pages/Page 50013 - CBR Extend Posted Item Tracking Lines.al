pageextension 50013 CBRExtendPstdItemTrackingLines extends "Posted Item Tracking Lines"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addfirst(Creation)
        {
            group(CBRIncomingDocument)
            {
                action("CBR IncomingDocCard")
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Enabled = HasIncomingDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = ViewOrder;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.CBRShowCard_ILEAndWarehouseentry("Serial No.", "Lot No.", "Item No.", "Variant Code");   //CBR_SS
                    end;

                }

                action("CBR SelectIncomingDoc")
                {
                    AccessByPermission = tabledata "Incoming Document" = R;
                    ApplicationArea = All;
                    Caption = 'Select Incoming Document';
                    Enabled = NOT HasIncomingDocument;
                    Image = SelectLineToApply;
                    Visible = false;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.SelectIncomingDocumentForPostedDocument(FORMAT("Entry No."), WORKDATE, RECORDID);//CAN_SC_22/02/2018..>>
                    end;
                }

                action("CBR IncomingDocAttachFile")
                {
                    ApplicationArea = All;
                    Caption = 'Attach File';
                    Enabled = NOT HasIncomingDocument;
                    Ellipsis = true;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.CBRNewAttachmentFromILE(Rec, "Lot No.", "Item No.", "Variant Code");//CBR_SS
                    end;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        HasIncomingDocument := CBRForIncomingDoc;//SS_CBR
    end;

    local procedure CBRForIncomingDoc(): Boolean
    var
        IncDoc: Record "Incoming Document";
    begin
        //CBR_SS_22/02/2018..>>
        IncDoc.RESET;
        IncDoc.SETRANGE("CBR Serial No.", "Serial No.");
        IncDoc.SETRANGE("CBR Lot No.", "Lot No.");
        IncDoc.SETRANGE("CBR Item No.", "Item No.");
        IncDoc.SETRANGE("CBR Variant Code", "Variant Code");
        IF IncDoc.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
        //CBR_SS_22/02/2018..<<
    end;

    var
        HasIncomingDocument: Boolean;
}