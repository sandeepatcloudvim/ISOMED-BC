pageextension 50045 CBRExtendBankAccountList extends "Bank Account List"
{
    layout
    {
        addafter("Search Name")
        {
            field(Balance; Balance)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}