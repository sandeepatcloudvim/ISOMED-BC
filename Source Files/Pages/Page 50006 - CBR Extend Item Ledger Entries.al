pageextension 50006 CBRExtendItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Unit of Measure Code"; "Unit of Measure Code")
            {
                ApplicationArea = All;
                Caption = 'UofM';
            }


        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = All;
            Caption = 'UofMQtyPer';
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("&Navigate")
        {
            group(CBRIncomingDocument)
            {
                action("CBR IncomingDocCard")
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.CBRShowCard_ILEAndWarehouseentry("Serial No.", "Lot No.", "Item No.", "Variant Code");//CBR_SS
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
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.CBRNewAttachmentFromILE(Rec, "Lot No.", "Item No.", "Variant Code");//CBR_SS
                                                                                                                       // IncomingDocumentAttachment.NewAttachmentFromDocument("Entry No.", 32, "Document Type", "Document No.");
                                                                                                                       // IncomingDocumentAttachment.
                    end;
                }
            }
        }
    }

    local procedure ForIncomingDoc(): Boolean
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

    trigger OnAfterGetCurrRecord()
    begin
        HasIncomingDocument := ForIncomingDoc      //CBR_SS
    end;

    var
        HasIncomingDocument: Boolean;
}