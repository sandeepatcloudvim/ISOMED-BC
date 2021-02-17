pageextension 50002 CBRExtendVendorCard extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Incoming Documents")
        {
            group(CBRIncomingDocument)
            {
                Caption = 'Vendor Document';

                action("CBR IncomingDocCard")
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Enabled = HasIncomingDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ViewOrder;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.CBRShowCard("No.");      //CBR_SS_29052018
                    end;

                }

                action("CBR SelectIncomingDoc")
                {
                    AccessByPermission = tabledata "Incoming Document" = R;
                    ApplicationArea = All;
                    Caption = 'Select Incoming Document';
                    Enabled = NOT HasIncomingDocument;
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.SelectIncomingDocumentForPostedDocument("No.", WORKDATE, RECORDID);    //CBR_SS_29052018
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
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPostedDocument("No.", WORKDATE)            //CBR_SS_29052018
                    end;
                }
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        CBRForIncomingDoc();
    end;

    local procedure CBRForIncomingDoc()
    begin
        //CBR_SS_22/02/2018..>>
        IncDoc.RESET;
        IncDoc.SETRANGE("Document No.", "No.");
        IF IncDoc.FINDFIRST THEN
            HasIncomingDocument := TRUE;
        //CBR_SS_22/02/2018..<<
    end;

    var
        HasIncomingDocument: Boolean;
        IncDoc: Record "Incoming Document";


}