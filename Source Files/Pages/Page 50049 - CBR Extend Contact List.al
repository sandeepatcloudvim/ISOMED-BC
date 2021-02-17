pageextension 50049 CBRExtendContactList extends "Contact List"
{
    layout
    {
        addafter("E-Mail")
        {
            field(Address; Address)
            {
                ApplicationArea = All;
            }
            field(City; City)
            {
                ApplicationArea = All;
            }
            field(County; County)
            {
                ApplicationArea = All;
            }
            field("CBR Lead Type"; "CBR Lead Type")
            {
                Caption = 'Lead Type';
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