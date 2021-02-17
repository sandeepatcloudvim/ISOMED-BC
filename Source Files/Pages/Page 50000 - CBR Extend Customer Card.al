pageextension 50000 CBRExtendCustomerCard extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Application Method")
        {
            field(CBRDefaultPONo; CBRDefaultPONo)
            {
                ApplicationArea = All;
                Caption = 'DefaultPONo';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Dimensions)
        {
            action("CBR Upate VAT")
            {
                ApplicationArea = All;
                Caption = 'Upate VAT';

                trigger OnAction()
                begin
                    CBRUpdateVATEntry();
                end;
            }
        }

        addafter("S&ales")
        {
            action("CBR Page Item Sales History")
            {
                ApplicationArea = all;
                Caption = 'Item Sales History';
                RunObject = page "Item Sales History";
                RunPageLink = "Customer No" = field("No.");

                Promoted = true;
                PromotedIsBig = true;
                Image = History;
                PromotedCategory = Process;
            }
        }

        addafter("Request Approval")
        {
            group(CBRIncomingDocument)
            {
                Caption = 'Customer Document';


                action("CBR IncomingDocCard")
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Enabled = HasIncomingDocument;
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
                    ApplicationArea = All;
                    Caption = 'Select Incoming Document';
                    Enabled = NOT HasIncomingDocument;
                    Image = SelectLineToApply;
                    AccessByPermission = tabledata "Incoming Document" = R;
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
                    Image = Attach;
                    Ellipsis = true;

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
        CBRForIncomingDoc;
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

    local procedure CBRUpdateVATEntry()
    var
        VATEntry: Record "VAT Entry";
        Progress: Dialog;
    begin
        Progress.OPEN('Updating..');
        VATEntry.RESET;
        VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::Invoice);
        VATEntry.SETFILTER(Base, '>%1', 0);
        IF VATEntry.FINDSET THEN
            REPEAT
                IF VATEntry.Base > 0 THEN BEGIN
                    VATEntry.Base := -(VATEntry.Base);
                    IF VATEntry.Amount > 0 THEN
                        VATEntry.Amount := -(VATEntry.Amount);
                    VATEntry.MODIFY;
                END;
            UNTIL VATEntry.NEXT = 0;

        VATEntry.RESET;
        VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::"Credit Memo");
        VATEntry.SETFILTER(Base, '<%1', 0);
        IF VATEntry.FINDSET THEN
            REPEAT
                IF VATEntry.Base < 0 THEN BEGIN
                    VATEntry.Base := -(VATEntry.Base);
                    IF VATEntry.Amount < 0 THEN
                        VATEntry.Amount := -(VATEntry.Amount);
                    VATEntry.MODIFY;
                END;
            UNTIL VATEntry.NEXT = 0;
        Progress.CLOSE;
        MESSAGE('Completed sucessfully');
    end;

    var
        HasIncomingDocument: Boolean;
        IncDoc: Record "Incoming Document";
}