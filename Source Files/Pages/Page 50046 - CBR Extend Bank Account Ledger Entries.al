pageextension 50046 CBRExtendBankAccLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("Document Date"; "Document Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Reversed)
        {
            field("Statement Status"; "Statement Status")
            {
                ApplicationArea = All;
            }
            field("Statement No."; "Statement No.")
            {
                ApplicationArea = All;
            }
            field("Statement Line No."; "Statement Line No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("F&unctions")
        {
            action("Update StmtNO")
            {
                CaptionML = ENU = 'Reset Statement';
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    BankAccLedgerEntry: Record "Bank Account Ledger Entry";
                BEGIN
                    IF NOT CONFIRM(' Do you want to reset the Bank Acc. Ledger Entry', FALSE) THEN
                        EXIT;
                    TESTFIELD(Open, TRUE);

                    BankAccLedgerEntry.RESET;
                    BankAccLedgerEntry.SETRANGE(Open, TRUE);
                    BankAccLedgerEntry.SETRANGE("Entry No.", "Entry No.");
                    IF BankAccLedgerEntry.FINDSET THEN
                        REPEAT
                            BankAccLedgerEntry."Statement No." := '';
                            BankAccLedgerEntry."Statement Status" := BankAccLedgerEntry."Statement Status"::Open;
                            BankAccLedgerEntry."Statement Line No." := 0;
                            BankAccLedgerEntry.MODIFY;
                            MESSAGE('Bank Acc. Ledger Entry has been updated %1', FORMAT(BankAccLedgerEntry."Entry No."));
                        UNTIL BankAccLedgerEntry.NEXT = 0;
                END;

            }
        }
    }

    var
        myInt: Integer;
}