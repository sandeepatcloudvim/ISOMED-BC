pageextension 50038 CBRExtendUserSetup extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("License Type"; "License Type")
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