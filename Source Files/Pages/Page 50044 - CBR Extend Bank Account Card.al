pageextension 50044 CBRExtendBankAccountCard extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Bank Acc.")
        {
            action("Update StmtNO")
            {
                ApplicationArea = All;
                Caption = 'Update StmtNO';

                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    BankAccLedgerEntry.RESET;
                    BankAccLedgerEntry.SETRANGE("Bal. Account Type", BankAccLedgerEntry."Bal. Account Type"::Customer);
                    BankAccLedgerEntry.SETRANGE(Open, TRUE);
                    BankAccLedgerEntry.SETFILTER("Statement No.", '<>%1', '10014');

                    IF BankAccLedgerEntry.FINDSET THEN
                        REPEAT
                            BankAccLedgerEntry."Statement No." := '';
                            BankAccLedgerEntry."Statement Status" := BankAccLedgerEntry."Statement Status"::Open;
                            BankAccLedgerEntry."Statement Line No." := 0;
                            BankAccLedgerEntry.MODIFY;
                        UNTIL BankAccLedgerEntry.NEXT = 0;
                    MESSAGE('Done');
                end;
            }
        }
    }

    var
        myInt: Integer;
        BankAccLedgerEntry: Record "Bank Account Ledger Entry";
}