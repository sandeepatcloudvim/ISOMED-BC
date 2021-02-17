pageextension 50043 CBRExtendVATEntries extends "VAT Entries"
{
    layout
    {
        addafter("Document No.")
        {

            field("Tax Type"; "Tax Type")
            {
                ApplicationArea = All;
            }
            field("Tax Liable"; "Tax Liable")
            {
                ApplicationArea = All;
            }
        }
        addafter("GST/HST")
        {
            field("Tax Group Code"; "Tax Group Code")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; "Tax Area Code")
            {
                ApplicationArea = All;
            }
            field("Tax Jurisdiction Code"; "Tax Jurisdiction Code")
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