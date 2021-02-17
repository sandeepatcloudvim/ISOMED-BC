report 50037 "CBR Change Log - Delete"
{
    Caption = 'Change Log - Delete';
    Permissions = TableData "Change Log Entry" = rid;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            DataItemTableView = SORTING ("Table No.", "Primary Key Field 1 Value");

            trigger OnAfterGetRecord()
            begin
                // DELETE;
                // EntriesDeleted := EntriesDeleted + 1;
                //CBR_SS 11/11/19 >><<
                RecChangeLogEntry.Reset;
                ReqDate := CalcDate('<-90D>', Today);
                CurrDate := CreateDateTime(ReqDate, 0T);

                RecChangeLogEntry.SetFilter("Date and Time", '<%1', CurrDate);
                if RecChangeLogEntry.Find('-') then
                    repeat
                        RecChangeLogEntry.DeleteAll;
                    until RecChangeLogEntry.Next = 0;
                //CBR_SS 11/11/19 >><<
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE(Text003,EntriesDeleted); //CBR_SS 11/11/19 >><<
            end;

            trigger OnPreDataItem()
            begin
                "Change Log Entry"."Date and Time" := CreateDateTime(Today, 0T); //CBR_SS 11/11/19 >><<
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        ChangeLogEntry: Record "Change Log Entry";
    begin
        //CBR_SS 11/11/19 >><<
        // IF "Change Log Entry".GETFILTER("Date and Time") <> '' THEN BEGIN
        //  ChangeLogEntry.COPYFILTERS("Change Log Entry");
        //  IF ChangeLogEntry.FINDLAST THEN
        //    IF DT2DATE(ChangeLogEntry."Date and Time") > CALCDATE('<-1Y>',TODAY) THEN
        //      IF NOT CONFIRM(Text002,FALSE) THEN
        //        CurrReport.QUIT;
        // END ELSE
        //  IF NOT CONFIRM(Text001,FALSE) THEN
        //    CurrReport.QUIT;
        //CBR_SS 11/11/19 >><<
    end;

    var
        Text001: Label 'You have not defined a date filter. Do you want to continue?';
        Text002: Label 'Your date filter allows deletion of entries that are less than one year old. Do you want to continue?';
        EntriesDeleted: Integer;
        Text003: Label '%1 entries were deleted.';
        RecChangeLogEntry: Record "Change Log Entry";
        FirstDate: Date;
        ReqDate: Date;
        CurrDate: DateTime;
}

