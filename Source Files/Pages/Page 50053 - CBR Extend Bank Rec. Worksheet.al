pageextension 50053 CBRExtendBankRecWorksheet extends "Bank Rec. Worksheet"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }


    var
        myInt: Integer;

    trigger OnClosePage()
    begin
        //CBR_SS..>>
        DoRecalc;
        //CBR_SS..<<
    end;


}