pageextension 50047 CBRExtendPhysInventJournal extends "Phys. Inventory Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Serial No."; "Serial No.")
            {
                ApplicationArea = All;
            }
            field("Lot No."; "Lot No.")
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