pageextension 50048 CBRExtendChangeLogEntries extends "Change Log Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Print")
        {
            action(RemoveLogEntries)
            {
                ApplicationArea = All;
                Caption = 'Remove Log Entries';
                Promoted = true;
                Image = Action;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    IF DIALOG.CONFIRM(Text002, TRUE) THEN BEGIN

                        DialogBox.OPEN('Processing Entries..');
                        RecChangeLogEntry.RESET;
                        ReqDate := CALCDATE('<-90D>', TODAY);
                        CurrDate := CREATEDATETIME(ReqDate, 0T);

                        RecChangeLogEntry.SETFILTER("Date and Time", '<%1', CurrDate);
                        IF RecChangeLogEntry.FIND('-') THEN
                            REPEAT
                                RecChangeLogEntry.DELETEALL;

                            UNTIL RecChangeLogEntry.NEXT = 0;
                    END;
                    DialogBox.CLOSE;
                    MESSAGE(Text001);
                end;
            }

        }
    }

    var
        myInt: Integer;
        RecChangeLogEntry: Record "Change Log Entry";
        RecDateVar: Date;
        DateFilter: Text;
        ReqDate: Date;
        CurrDate: DateTime;
        Text001: Label 'ENU=Log entries deleted successfully.';
        Text002: Label 'ENU=Remove log entries older than 90 Days ?';
        DialogBox: Dialog;
}