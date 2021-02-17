pageextension 50004 CBRExtendItemCard extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Caption = 'Description 2';
            }
        }
        addbefore("Vendor No.")
        {
            field("Manufacturer Code"; "Manufacturer Code")
            {
                ApplicationArea = All;
                Caption = 'Manufacturer Code';
            }
        }
        addbefore("Warehouse Class Code")
        {
            field(CBRUnitCostCommission; CBRUnitCostCommission)
            {
                Caption = 'Unit Cost Commission';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter(Identifiers)
        {
            action("CBR HTML Script")
            {
                ApplicationArea = All;
                Caption = 'HTML Script';
                RunObject = Page "Item HTM Script";
                RunPageOnRec = true;
                RunPageView = SORTING("Item No.", "Line No.");
                RunPageLink = "Item No." = FIELD("No.");
                Image = Document;
            }
        }

        addbefore(Approval)
        {
            group(CBRIncomingDocument)
            {
                Caption = 'Item Documents';

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

                action("CBR IncomingDocAttachFile")
                {
                    ApplicationArea = All;
                    Caption = 'Attach File';
                    Enabled = NOT HasIncomingDocument;
                    Ellipsis = true;
                    Image = Attach;

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