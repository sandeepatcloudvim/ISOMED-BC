pageextension 50011 CBRExtendItemTrackingEntries extends "Item Tracking Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Navigate")
        {
            action("CBR IncomingDocCard")
            {
                ApplicationArea = All;
                Caption = 'View File';
                Enabled = HasIncomingDocument;
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                begin
                    IncomingDocument.CBRShowCard_ILEAndWarehouseentry("Serial No.", "Lot No.", "Item No.", "Variant Code");   //CBR_SS
                end;
            }
            action("CBR SelectIncomingDoc")
            {
                ApplicationArea = All;
                Caption = 'Select Incoming Document';
                Enabled = NOT HasIncomingDocument;
                AccessByPermission = tabledata "Incoming Document" = R;
                Image = SelectLineToApply;
                Visible = false;
                trigger OnAction()
                var
                    IncomingDocument: Record "Incoming Document";
                begin
                    IncomingDocument.SelectIncomingDocumentForPostedDocument(FORMAT("Entry No."), "Posting Date", RECORDID);//CAN_SC_22/02/2018..>>
                end;
            }
            action("CBR IncomingDocAttachFile")
            {
                ApplicationArea = All;
                Caption = 'Attach File';
                Enabled = NOT HasIncomingDocument;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Ellipsis = true;
                trigger OnAction()
                var
                    IncomingDocumentAttachment: Record "Incoming Document Attachment";
                begin
                    IncomingDocumentAttachment.CBRNewAttachmentFromILE(Rec, "Lot No.", "Item No.", "Variant Code");                 //CBR_SS
                end;
            }
            action("CBR Report")
            {
                ApplicationArea = All;
                Caption = 'Print Label';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    //CBR_SS_09/05/2018..>>
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50022, TRUE, FALSE, Rec);
                    RESET;
                    //CBR_SS_09/05/2018..<<
                end;

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        HasIncomingDocument := CBRForIncomingDoc  //CBR_SS
    end;

    local procedure CBRForIncomingDoc(): Boolean
    var
        IncDoc: Record "Incoming Document";
    begin
        //CBR_SS_22/02/2018..>>
        IncDoc.RESET;
        //IncDoc.SETRANGE("CBR Serial No.", "Serial No.");
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