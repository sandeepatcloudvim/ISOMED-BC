pageextension 50012 CBRExtendItemTrackingLines extends "Item Tracking Lines"
{
    layout
    {
        // Add changes to page layout here
        modify("Lot No.")
        {
            ApplicationArea = All;
            trigger OnBeforeValidate()
            begin
                CBRDeleteInconsistentSalesLine(Rec); //CBR_SS 24Dec2018
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(ButtonLine)
        {
            group(CBRIncomingDocument)
            {
                Caption = 'Incoming Documents';

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
                        CBRGetItemLedgerEntry;
                        IncomingDocumentAttachment.CBRNewAttachmentFromILE(ItemLedgerEntry, "Lot No.", "Item No.", "Variant Code");//CBR_SS
                    end;
                }
            }
        }
        addafter(FunctionsDemand)
        {
            group("CBR Label")

            {
                Caption = 'Label';

                action("Print Label")
                {
                    ApplicationArea = All;
                    Caption = 'Print Label';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        TestReport: Report "Production Label For Item";
                    begin
                        //CBR_SS_11/05/2018 >>
                        TESTFIELD("Source ID");
                        TESTFIELD("Source Ref. No.");
                        TestReport.InitValue("Source ID", "Source Ref. No.");
                        TestReport.RUN;
                        //CBR_SS_11/05/2018 <<
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        HasIncomingDocument := CBRForIncomingDoc;//SS_CBR
    end;

    local procedure CBRGetItemLedgerEntry()
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Serial No.", "Serial No.");
        ItemLedgerEntry.SETRANGE("Lot No.", "Lot No.");
        ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgerEntry.SETRANGE("Variant Code", "Variant Code");
        IF ItemLedgerEntry.FINDFIRST THEN;
        HasIncomingDocument := CBRForIncomingDoc;
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

    local procedure CBRDeleteInconsistentSalesLine(VAR TrackingSpecification: Record "Tracking Specification")
    var
        SalesLine: Record "Sales Line";
        RecReservationEntry: Record "Reservation Entry";
    begin
        //CBR_SS++ 24Dec2018
        RecReservationEntry.RESET;
        RecReservationEntry.SETCURRENTKEY(
          "Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.");
        RecReservationEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
        RecReservationEntry.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        RecReservationEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");
        RecReservationEntry.SETFILTER("Item Tracking", '<>%1', RecReservationEntry."Item Tracking"::None);
        IF RecReservationEntry.FINDSET THEN
            REPEAT
                IF (RecReservationEntry."Reservation Status" = RecReservationEntry."Reservation Status"::Prospect)
                  AND (RecReservationEntry."Source Type" = DATABASE::"Sales Line") AND (RecReservationEntry."Source Subtype" = 2)
                THEN
                    IF NOT SalesLine.GET(RecReservationEntry."Source Subtype", RecReservationEntry."Source ID", RecReservationEntry."Source Ref. No.") THEN;
                RecReservationEntry.DELETE;
            UNTIL RecReservationEntry.NEXT = 0;
        COMMIT;
        //CBR_SS-- 24Dec2018
    end;

    var
        HasIncomingDocument: Boolean;
        ItemLedgerEntry: Record "Item Ledger Entry";
}