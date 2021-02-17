pageextension 50028 CBRExtendChartofAccounts extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Periodic Activities")
        {
            action("CBR Management DashBoard")
            {
                Caption = 'Management DashBoard';
                ApplicationArea = All;
                RunObject = Page "Management Dashboard";
                Promoted = true;
                PromotedIsBig = true;
                Image = Register;
                PromotedCategory = New;
            }
        }
    }

    var
        myInt: Integer;
}